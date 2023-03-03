//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/22/1401 AP.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins : [CoinModel] = []
    var coinSubscription : AnyCancellable?
    
    init() {
        getCoin()
    }
     func getCoin () {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")else {return}
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handelError, receiveValue: {[weak self] (returnConis) in
                self?.allCoins = returnConis
                self?.coinSubscription?.cancel()
            })
        
        
    }
}
