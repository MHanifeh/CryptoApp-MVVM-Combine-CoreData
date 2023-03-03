//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/27/1401 AP.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData : MarketDataModel? = nil
    var marketSubscription : AnyCancellable?
    
    init() {
        getDate()
    }
    
     func getDate(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else{return}
        
        marketSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handelError, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketSubscription?.cancel()
            })
    }
}
