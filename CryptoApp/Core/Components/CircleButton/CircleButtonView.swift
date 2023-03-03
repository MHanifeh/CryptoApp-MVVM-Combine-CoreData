//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/20/1401 AP.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName : String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.thems.accentColor)
            .frame(width:50,height:50)
            .background(
                Circle()
                    .foregroundColor(Color.thems.backgroundColor)
            )
            .shadow(color: Color.thems.accentColor.opacity(0.4), radius: 10,x: 0,y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
         
    }
}
