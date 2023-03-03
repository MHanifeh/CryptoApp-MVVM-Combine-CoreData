//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/26/1401 AP.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.thems.secondaryColor : Color.thems.accentColor
                )
            TextField("Search By Name Or Symbol ... ", text: $searchText)
                .foregroundColor(Color.thems.accentColor)
                .autocorrectionDisabled(true)
//                .disableAutocorrection(true)
            
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x:10)
                    .foregroundColor(Color.thems.accentColor)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0 )
                ,alignment: .trailing
                )
            
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    
                searchText = ""
            }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.thems.backgroundColor)
                .shadow(color: Color.thems.accentColor.opacity(0.15), radius: 10,x: 0,y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
