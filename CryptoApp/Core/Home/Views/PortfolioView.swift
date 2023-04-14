//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 12/7/1401 AP.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectedCoin : CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark :  Bool = false

    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading,spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil{
                       portfoiliInputSection
                    }
                }
            }
                .navigationTitle("Edite Portfolio")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                       XmarkBtn
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                      tralingNavBarButton
                    }
                   
                    
                })
                .onChange(of: vm.searchText) { newValue in
                    if newValue == ""{
                        removeSelection()
                    }
                }
               
            
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
//    Coin List
    private var coinLogoList : some View{
      
                ScrollView(.horizontal,showsIndicators: false){
                    LazyHStack(spacing:10){
                        ForEach(vm.searchText.isEmpty ?vm.portfolioCoins : vm.allCoins){coin in
                            CoinLogoView(coin: coin)
                                .frame(width: 75)
                                .padding(5)
                                .onTapGesture {
                                    withAnimation(.easeIn){
                                        uppdateSelectedCoin(coin: coin)
                                    }
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedCoin?.id == coin.id ? Color.thems.green : Color.clear,lineWidth: 1)
                                )
                            
                        }
                    }
                    .padding(.vertical,4)
                    .padding(.leading)
                }
            
            
        
    }
    private func uppdateSelectedCoin(coin : CoinModel){
        selectedCoin = coin
        
       if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
          let amount = portfolioCoin.currentHoldings{
           quantityText = "\(amount)"
       }else{
           quantityText = ""
       }
    }
//    Xmark On Top Left Corner
    private var XmarkBtn : some View{
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })

    }
    
    
    
    private func getCurrentValue () -> Double{
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    private var portfoiliInputSection : some View{
        VStack(spacing: 20){
            HStack{
                Text("Current Price Of \(selectedCoin?.symbol.uppercased() ?? "") : ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount In Your Portfolio:")
                  
                Spacer()
                TextField("Ex . 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value : ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .padding(.top)
        .font(.subheadline)
    }
    private var tralingNavBarButton : some View{
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)

        }
        .font(.headline)
    }
    private func saveButtonPressed(){
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else{return}
        
        // save to portfolio
         vm.uppdatePortfolio(coin: coin, amount: amount)

        //show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelection()
        }
        
        //hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut) {
                showCheckmark = false
            }
      
        }
    }
    private func removeSelection(){
        selectedCoin = nil
        vm.searchText = ""
    }
}
