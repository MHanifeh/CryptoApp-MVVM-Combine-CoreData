//
//  Data.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 1/23/1402 AP.
//

import Foundation

extension Date{
    
    init (coinGekoString : String){
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd-'T'HH:mm:ss.SSSZ"
        let date = formater.date(from: coinGekoString) ?? Date()
        self.init(timeInterval: 0, since: date)
        
    }
    private var shortformate : DateFormatter{
        let formater = DateFormatter()
        formater.dateStyle = .short
        return formater
    }
    func asShortDateString()->String{
        return shortformate.string(from: self)
    }
}
