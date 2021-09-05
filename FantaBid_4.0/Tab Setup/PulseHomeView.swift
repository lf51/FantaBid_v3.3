//
//  PulseHomeView.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 28/08/21.
//

import SwiftUI

struct PulseHomeView: View {
    
    @State private var animationAmount: CGFloat = 1
    @Binding var buttonAction: Bool
    
    var body: some View {
        Button("Start") {
            withAnimation(.easeInOut(duration: 1.0)) {
                
                self.buttonAction.toggle()
            }
            
           
        }
        .padding(80)
        .font(.system(.headline, design: .monospaced))
        .background(Color.orange)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.orange)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}

/*
struct PulseHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            PulseHomeView(buttonAction: .constant(false), secondAction: .constant(false))
            PulseHomeView(buttonAction: .constant(false), secondAction: .constant(false))
                .preferredColorScheme(.dark)
        }
        
    }
}

*/
