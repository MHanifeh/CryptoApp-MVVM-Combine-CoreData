//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 12/7/1401 AP.
//

import SwiftUI

struct CoinLogoView: View {
    let coin : CoinModel
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50,height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.thems.accentColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.thems.secondaryColor)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
     
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
    }
}
