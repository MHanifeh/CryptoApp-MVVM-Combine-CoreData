//
//  Color.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/19/1401 AP.
//

import Foundation
import SwiftUI

extension Color{
    
    static let thems = ColorTheme()
    static let launch = LaunchScreen()
    
}

struct ColorTheme{
    let accentColor = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let secondaryColor = Color("SecondaryTextColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
}

struct LaunchScreen {
    let accent = Color("LaunchAccentColor")
    let backGround = Color("LaunchBackgroundColor")
}
