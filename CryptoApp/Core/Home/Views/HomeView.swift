//
//  HomeView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/20/1401 AP.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortfolio : Bool = false
    @State private var showPortfolioView : Bool = false
    
    @State private var selectedCoin : CoinModel? = nil
    @State private var showDetailView : Bool = false
    var body: some View {
        ZStack{
            Color.thems.backgroundColor
                .ignoresSafeArea()

                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            VStack{
            homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                
            columnTitles
                
                if !showPortfolio{
            allCoinList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                  portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
           
                Spacer(minLength: 0)
            }
        }
        .background(
            NavigationLink(
                 destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                 label: {EmptyView()}
            )
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}



extension HomeView{
    private var homeHeader : some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonViewAnimation(animate: $showPortfolio)
                        
                )
            Spacer()
            Text( showPortfolio ?   "Portfolio":"Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
                
        }
        .padding(.horizontal)
    }
    
    private var allCoinList :some View{
        List{
            ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin , showHoldingColumn: false)
                      .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                      .onTapGesture {
                          segue(coin: coin)
                      }
             
            }
        }
        
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin: CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
    }
    private var portfolioCoinList :some View{
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin , showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        
            
          
        }
        
        .listStyle(PlainListStyle())
    }
    private var columnTitles : some View {
        HStack{
            HStack(spacing:4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(degrees: vm.sortOptions == .rank ? 0 : 180))
                    .opacity((vm.sortOptions == .rank || vm.sortOptions == .rankReversed) ? 1.0 : 0.0)
                 
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOptions = vm.sortOptions == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            if showPortfolio{
                HStack (spacing:4){
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .rotationEffect(Angle(degrees: vm.sortOptions == .holdings ? 0 : 180))
                        .opacity((vm.sortOptions == .holdings || vm.sortOptions == .holdingsreversed) ? 1.0 : 0.0)
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOptions = vm.sortOptions == .holdings ? .holdingsreversed : .holdings
                    }
                }
            }
            
            HStack(spacing:4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(degrees: vm.sortOptions == .price ? 0 : 180))
                    .opacity((vm.sortOptions == .price || vm.sortOptions == .priceReversed) ? 1.0 : 0.0)
            }
                .frame(width:UIScreen.main.bounds.width/3.5,alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOptions = vm.sortOptions == .price ? .priceReversed : .price
                    }
                }
            Button {
                withAnimation(.linear(duration: 2.0)){
                    vm.reloadData()
                }
            
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0),anchor: .center)

        }
        .padding(.horizontal)
        .font(.caption)
        .foregroundColor(Color.thems.secondaryColor)
        
    }
}
