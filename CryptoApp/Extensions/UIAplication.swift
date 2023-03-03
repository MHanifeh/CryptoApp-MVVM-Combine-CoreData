//
//  UIAplication.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/26/1401 AP.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
