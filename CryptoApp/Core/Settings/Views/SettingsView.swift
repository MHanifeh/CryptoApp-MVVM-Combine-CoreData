//
//  SettingsView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 1/24/1402 AP.
//

import SwiftUI

struct SettingsView: View {
    @Environment (\.presentationMode) var presentationMode
    
    let defaultUrl = URL(string: "https://www.google.com")!
    let github = URL(string: "https://www.github.com")!
    let youtube = URL(string: "https://www.youtube.com")!
    let coinGekoUrl = URL(string: "https://www.coinGeko.com")!
    var body: some View {
        NavigationView {
            List{
                aboutSection
                coinGekoSection
                developer
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkBtn
                }
            })
            
            
            
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}



extension SettingsView {
    //    Xmark On Top Left Corner
    private var XmarkBtn : some View{
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
        
    }
    
    private var aboutSection : some View{
        Section(header: Text("About")) {
            VStack(alignment: .leading,spacing: 10) {
                
                Image("logo")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius:20))
                Text("This app was made for personal usage  in SwiftUi and MVVM and Combine by respecting Clean Arcetecture rules  .")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color.thems.accentColor)
                
                
                
                
                Divider()
                    .padding(.vertical)
                Link("Subscribe on YouTube", destination: youtube)
                Link("Github", destination: github)
            }
        }
    }
    private var coinGekoSection : some View{
        Section(header: Text("CoinGeko")) {
            VStack(alignment: .leading,spacing: 10) {
                
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.horizontal)
                Text("We used API from CoinGeco.com for buiding this app .Thx from coinGeko for API .")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color.thems.accentColor)
                Divider()
                    .padding(.vertical)
                Link("CoinGeco Website", destination: coinGekoUrl)
                Link("Github", destination: github)
            }
            
        }
    }
    
    private var developer : some View{
        Section(header: Text("Developer")) {
            VStack(alignment: .leading,spacing: 10) {
                HStack {
                    Image("YoungMan")
                        .resizable()
                        .frame(width: 100,height: 100)
                        .clipShape(RoundedRectangle(cornerRadius:20))
                    Text("This app was made up by this young man and all right was reversed by him and any CopyRight made him piss off  .")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(Color.thems.accentColor)
                        .frame(height: 100)
                    
                    
                    
                    
                }
                Divider()
                    .padding(.vertical)
                Link("Subscribe on YouTube", destination: youtube)
                Link("Github", destination: github)
            }
        }
    }
    
    private var applicationSection : some View{
        
        Section(header: Text("Application")){
            Link("Terms Of Service", destination: defaultUrl)
            Link("Privacy Policy", destination: defaultUrl)
            Link("Company Website", destination: defaultUrl)
            Link("Learn More", destination: defaultUrl)
        }
    }
    
    
}
