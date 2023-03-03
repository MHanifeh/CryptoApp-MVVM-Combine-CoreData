//
//  StatisticView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/27/1401 AP.
//

import SwiftUI

struct StatisticView: View {
    let state : StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            
            Text(state.title)
                .font(.caption)
                .foregroundColor(Color.thems.secondaryColor)
            Text(state.value)
                .font(.headline)
                .foregroundColor(Color.thems.accentColor)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees:(state.percentage ?? 0) >= 0 ? 0 : 180))
                    .foregroundColor((state.percentage ?? 0) >= 0 ?  Color.thems.green : Color.thems.red)
                Text(state.percentage?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }.foregroundColor((state.percentage ?? 0) >= 0 ?  Color.thems.green : Color.thems.red)
                .opacity(state.percentage == nil ? 0 : 1)
            
        }
    }
}

struct StatisticViewPreviews: PreviewProvider {
    static var previews: some View {
        StatisticView(state: dev.state1)
            .previewLayout(.sizeThatFits)
        StatisticView(state: dev.state2)
            .previewLayout(.sizeThatFits)
        StatisticView(state: dev.state3)
            .previewLayout(.sizeThatFits)
    }
}
