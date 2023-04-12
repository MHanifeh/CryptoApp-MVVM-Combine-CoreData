//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 12/17/1401 AP.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject{
    
    @Published var overviewStatistics : [StatisticModel] = []
    @Published var additionalStatistics : [StatisticModel] = []
    @Published var coinDescription : String? = nil
    @Published var websitURL : String? = nil
    @Published var redditURL : String? = nil
    
    @Published var coin :  CoinModel
    
    private let coinDetailServices : CoinDetailDataService
    private var cancelables = Set<AnyCancellable>()
    init(coin : CoinModel){
        self.coin = coin
        self.coinDetailServices = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailServices.$CoinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink {[weak self](returnedArrays)  in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancelables)
        
        coinDetailServices.$CoinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websitURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancelables)

    }
    
    
    // get data from coin  model and detail model
    
    private func mapDataToStatistics(coinDetailModel:CoinDetailModel? , coinModel:CoinModel)->(overview : [StatisticModel] , additional : [StatisticModel]){
        
       let overviewArray = createOverViewArray(coinModel: coinModel)
        let additionalArray = creatAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        return (overviewArray,additionalArray)
        
    }
    
    // overView
    private func createOverViewArray(coinModel:CoinModel)->[StatisticModel]{
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceState = StatisticModel(title: "Curent Price", value: price , percentage: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapState = StatisticModel(title: "Market Capitalization", value: marketCap, percentage: marketCapPercentageChange)
        
        let rank = "\(coinModel.rank)"
        let rankState = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeState = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray : [StatisticModel] = [
            priceState , marketCapState , rankState , volumeState
        ]
        return overviewArray
    }
    
    
    //additional view
    private func creatAdditionalArray(coinModel:CoinModel,coinDetailModel:CoinDetailModel?)->[StatisticModel]{
        let hight = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highstate = StatisticModel(title: "24 High", value: hight)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowState = StatisticModel(title: "24 Low", value: low)
        
        let priceChange = coinModel.priceChangePercentage24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceChangeState = StatisticModel(title: "24h PriceChange", value: priceChange,percentage: pricePercentageChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChangePercentage24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentage = coinModel.marketCapChangePercentage24H
        let marketCapChangeState = StatisticModel(title: "24h Market Cap Change", value: marketCapChange,percentage: marketCapPercentage)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockState = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingState = StatisticModel(title: "Hashing Algoritm", value: hashing)
        
        
        let additionalArray : [StatisticModel] = [
            highstate ,lowState,priceChangeState,marketCapChangeState,blockState,hashingState
        ]
        return additionalArray
    }
}
