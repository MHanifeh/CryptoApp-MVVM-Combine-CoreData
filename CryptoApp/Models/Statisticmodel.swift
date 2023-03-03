//
//  Statisticmodel.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/27/1401 AP.
//

import Foundation


struct StatisticModel :Identifiable{
    let id = UUID().uuidString
    let title : String
    let value : String
    let percentage : Double?
    
    init(title: String, value: String, percentage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentage = percentage
    }
}
