//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/19/1401 AP.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject private var vm  = HomeViewModel()
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.thems.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.thems.accentColor)]

    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView( )
                    .navigationBarHidden(true)

                                        
            }
            .environmentObject(vm)
            
        }
    }
}
