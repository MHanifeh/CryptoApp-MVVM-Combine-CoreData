//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/21/1401 AP.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    
    @Published var statistics : [StatisticModel] = []
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var isLoading : Bool = false
    @Published var searchText : String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init(){
        addSubscriber()
    }
    func addSubscriber (){
        // update allcoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterCoin)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
        
        //uppdate portfolio
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mappAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancelables)
        
        // uppdate market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map (mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancelables)
        
        
        
        
    }
    
    func uppdatePortfolio (coin : CoinModel , amount : Double){
        portfolioDataService.uppdatePortfolio(coin: coin, amount: amount)
    }
    func reloadData(){
        isLoading = true
        coinDataService.getCoin()
        marketDataService.getDate()
        HapticManager.notification(type: .success)
    }
    private func filterCoin (text:String , coins: [CoinModel])->[CoinModel]{
        guard !text.isEmpty else{
            return coins
        }
        let lowerCasedCoins = text.lowercased()
        
        return coins.filter { (coin)-> Bool in
            return coin.name.lowercased().contains(lowerCasedCoins) ||
            coin.symbol.lowercased().contains(lowerCasedCoins) ||
            coin.id.lowercased().contains(lowerCasedCoins)
        }
    }
    private func mappAllCoinsToPortfolioCoins(allCoins : [CoinModel],portfolioEntities:[PortfolioEntity])->[CoinModel]{
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where:{$0.coinID == coin.id})else{
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    private func mapGlobalMarketData(marketDataModel:MarketDataModel?,portfolioCoins : [CoinModel]) -> [StatisticModel]{
        var stats : [StatisticModel] = []
        guard let data = marketDataModel else{
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,percentage: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "Btc Dominance", value: data.btcDominance)
        
        
        let portfolioValue =
        portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        
        let perviousValue =
        portfolioCoins
            .map { (coin)->Double in
                let currentValue = coin.currentHoldingsValue
                let percentage = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentage)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - perviousValue) / perviousValue) * 100
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith6Decimals(),
            percentage: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
