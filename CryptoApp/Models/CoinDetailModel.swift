//
//  CoinDetailModel.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 12/17/1401 AP.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false

 */

struct CoinDetailModel : Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case description, links
    }
    
    var readableDescription : String?{
       return description?.en?.removingHtmlOccurences
    }
    
}

struct Description  : Codable{
    let en: String?
}

struct Links : Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum codingKeys : String , CodingKey{
        case homepage
        case subredditURL = "subreddit_url"
    }
}
