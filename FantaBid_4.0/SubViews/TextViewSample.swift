//
//  TextViewSample.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 15/07/21.
//

import SwiftUI

struct TextViewSample: View {
    
    var nomeCampo:String
    var valoreCampo:String
    
    var body: some View {
       
        HStack(alignment: .center, spacing: nil){
            
        Text(nomeCampo)
            .frame(width: 150.0,alignment: .leading)
            .font(.system(.callout))
            .shadow(radius: 5)
       
        Divider()
       
            Text(valoreCampo).font(.system(.callout, design: .monospaced)).foregroundColor(.secondary).padding(.leading,50)
        
        }
    }
}

struct TextViewSample_Previews: PreviewProvider {
    static var previews: some View {
        TextViewSample(nomeCampo: "Giocatori in Rosa", valoreCampo: "14")
    }
}
