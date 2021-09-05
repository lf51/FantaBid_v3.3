//
//  MonoText.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 08/07/21.
//

import SwiftUI

struct CampoTextView: View {
    
    var nomeCampo:String?
    var placeholderCampo:String
    
    @Binding var bindingCampo:String
    var isValueOk:Bool
    
    @State var isWriting:Bool = false
    
    var body: some View {
        
        HStack(alignment: .center, spacing: nil){
            
            if nomeCampo != nil {
            Text(nomeCampo!)
                .frame(width: 100.0,alignment: .leading)
                .font(.system(.callout))
                .shadow(radius: 5)
           
            Divider()
            }
            
            TextField(placeholderCampo, text: $bindingCampo)
                .font(.system(.callout, design: .monospaced))
               
                .disableAutocorrection(true)
                
            Spacer()
            
            if bindingCampo == "" { Image(systemName:"checkmark.circle").foregroundColor(.secondary) }
            else {
                if isValueOk {Image(systemName:"checkmark.circle.fill").foregroundColor(.green)}
                else {Image(systemName: "multiply.circle.fill").foregroundColor(.red)}
            }
           
        }
      
    }
}


struct CampoTextView_Previews: PreviewProvider {
    @ObservedObject static var lega:FederationLeaguesData = FederationLeaguesData()
    
    static var previews: some View {
        CampoTextView(nomeCampo:nil,placeholderCampo: "nome squadra", bindingCampo: $lega.nomeLega, isValueOk: lega.isNomeLegaOk)
 
    }
}



