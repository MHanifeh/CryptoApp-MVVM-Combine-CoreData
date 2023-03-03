//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/27/1401 AP.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    @Binding var showPortfolio : Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics){stat in
                StatisticView(state: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width , alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
