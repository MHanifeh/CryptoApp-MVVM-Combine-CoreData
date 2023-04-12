//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 12/17/1401 AP.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var CoinDetails :CoinDetailModel?=nil
    
    var coinDetailSubscription : AnyCancellable?
    var coin : CoinModel
    
    init(coin : CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
     func getCoinDetails () {
        
        guard let url = URL(string:
                                "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false")else {return}
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type:CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handelError, receiveValue: {[weak self] (returnCoinDetail) in
                self?.CoinDetails = returnCoinDetail
                self?.coinDetailSubscription?.cancel()
            })
        
        
    }
}

