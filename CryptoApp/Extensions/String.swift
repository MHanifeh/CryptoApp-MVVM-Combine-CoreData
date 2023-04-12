//
//  String.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 1/23/1402 AP.
//

import Foundation

extension String{
    var removingHtmlOccurences : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression,range: nil)
    }
}
