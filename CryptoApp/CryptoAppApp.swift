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
    @State private var showLaunchView: Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.thems.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.thems.accentColor)]
        
    }
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)

                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
