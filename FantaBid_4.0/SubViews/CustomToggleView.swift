//
//  CustomToggleView.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 08/07/21.
//

import SwiftUI

struct CustomToggleView:View {
  
    @Binding var isActive:Bool
    var testoTrue:String
    var testoFalse:String
    
    var body: some View {
        
        withAnimation(.default) {
            Toggle(isOn: $isActive, label: {
                Text(isActive ? testoTrue : testoFalse).font(.system(.subheadline, design: .monospaced)).foregroundColor(isActive ? .primary : .secondary).shadow(radius: isActive ? 5 : 0)
                })
        }
      
    }
    
}

struct CustomToggleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomToggleView(isActive: .constant(true), testoTrue: "Ciao", testoFalse: "Addio")
    }
}
