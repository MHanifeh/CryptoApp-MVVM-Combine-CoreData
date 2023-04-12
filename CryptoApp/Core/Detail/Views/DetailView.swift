//
//  DetailView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 12/16/1401 AP.
//

import SwiftUI

struct DetailLoadingView : View{
    @Binding var coin : CoinModel?
    
    var body : some View{
        ZStack{
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}

//
// ------------------------- main -----------------------------
//

struct DetailView: View {
    
    @StateObject var vm : DetailViewModel
    @State private var isRotated = 0.0
    @State private var showFullDescription : Bool = false
    
    
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing : CGFloat = 30
    init(coin:CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing:20){
                    overViewText
                    Divider()
                    coinDescription
                    overViewGrid
                    additionalDetails
                    Divider()
                    additionlaGrid
                    webSiteSection
                }
                .padding()
            }
            
        }
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack{
                    Text(vm.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundColor(Color.thems.secondaryColor)
                    toolbarIcon
                }
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin:dev.coin)
        }
        
    }
}

extension DetailView {
    private var toolbarIcon:some View{
        CoinImageView(coin: vm.coin)
            .frame(width: 25,height: 25)
            .rotationEffect(.degrees(isRotated))
            .onAppear{
                withAnimation(.linear(duration: 0.4)
                    .speed(0.1).repeatForever(autoreverses: false)) {
                        isRotated = 360.0
                    }
                
            }
    }
    private var overViewText : some View{
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundColor(Color.thems.accentColor)
            .frame(maxWidth:.infinity , alignment: .leading)
    }
    private var additionalDetails : some View{
        Text("AdditionalDetails")
            .font(.title)
            .bold()
            .foregroundColor(Color.thems.accentColor)
            .frame(maxWidth:.infinity , alignment: .leading)
    }
    private var overViewGrid : some View{
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistics) { state in
                    StatisticView(state: state)
                }
            }
    }
    private var additionlaGrid : some View{
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStatistics) { state in
                    StatisticView(state: state)
                }
            }
    }
    private var coinDescription : some View{
        ZStack{
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil:3)
                        .font(.callout)
                        .foregroundColor(Color.thems.secondaryColor)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                        
                    } label: {
                        Text(showFullDescription ? "Read Less":"Read More ...")
                    }
                    .foregroundColor(.blue)
                    .font(.caption)
                    .padding(.vertical,2)
                    
                }
                .frame(maxWidth:.infinity,alignment:.leading)
                
            }
        }
    }
    
    
    private var webSiteSection:some View{
        
        VStack(alignment:.leading , spacing: 20){
            
            if let webSiteString = vm.websitURL,
               let url = URL(string: webSiteString){
                Link("Website", destination: url)
                
            }
            if let redditString = vm.redditURL,
               let url = URL(string: redditString){
                Link("Reddit", destination: url)
            }
        }
        .foregroundColor(.blue)
        .font(.headline)
        .frame(maxWidth:.infinity,alignment:.leading)
    }
}
