//
//  CircleButtonViewAnim.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/20/1401 AP.
//

import SwiftUI

struct CircleButtonViewAnimation: View {
    
    @Binding var animate : Bool
    
    var body: some View {
      Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0)
            .opacity(animate ? 0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 0.8) : .none)
           
            
    }
}

struct CircleButtonViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonViewAnimation(animate: .constant(true))
            .foregroundColor(.red)
            .frame(width:100,height: 100)
    }
}
