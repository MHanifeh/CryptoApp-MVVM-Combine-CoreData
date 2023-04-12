//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/20/1401 AP.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingColumn : Bool
    
    
    var body: some View {
        HStack(spacing:0) {
            leftColumn
            Spacer()
            if showHoldingColumn{
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background(
            Color.thems.backgroundColor.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin:dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin:dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}





// Extension 3 column of view  Left / Center / Right


extension CoinRowView{
    
    private var leftColumn : some View{
        HStack(spacing:0){
            Text("\(coin.rank)")
                .foregroundColor(Color.thems.secondaryColor)
                .font(.caption)
                .frame(minWidth:20)
            CoinImageView(coin: coin)
                .frame(width:30,height:30)
            Text(coin.symbol.uppercased())
                .foregroundColor(Color.thems.accentColor)
                .font(.headline)
                .padding(.leading,6)
               
        }
    }
    
    private var centerColumn : some View{
        VStack(alignment:.trailing){
            Text("\(coin.currentHoldingsValue.asCurrencyWith2Decimals())")
                .bold()
                .foregroundColor(Color.thems.accentColor)
            Text((coin.currentHoldings ?? 0 ).asNumberString())
                .foregroundColor(Color.thems.accentColor)
        }
    }
    
    private var rightColumn  : some View{
        
        VStack(alignment:.trailing){
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundColor(Color.thems.accentColor)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24HInCurrency ?? 0) >= 0 ?
                    Color.thems.green :
                        Color.thems.red
                )
            
        }
        .frame(width:UIScreen.main.bounds.width/3.5,alignment: .trailing)
    }
    
    
}
