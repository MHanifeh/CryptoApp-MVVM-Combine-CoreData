//
//  xmarkButton.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 12/7/1401 AP.
//

import SwiftUI

struct xmarkButton: View {
    @Environment (\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color.thems.accentColor)
        })
    }
}

struct xmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        xmarkButton()
            
    }
}
