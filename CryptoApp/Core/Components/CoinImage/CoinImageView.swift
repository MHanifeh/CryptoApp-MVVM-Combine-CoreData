//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/24/1401 AP.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm : CoinImageViewModel
    
    init(coin : CoinModel){
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack{
            if let image = vm.image{
                Image(uiImage : image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading{
                ProgressView()
            }else{
                Image(systemName: "questionmark")
                    .foregroundColor(Color.thems.secondaryColor)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
