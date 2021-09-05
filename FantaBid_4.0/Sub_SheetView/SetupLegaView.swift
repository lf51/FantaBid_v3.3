//
//  SetupLegaView.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 08/07/21.
//

import SwiftUI

struct SetupLegaView: View {
    
   @ObservedObject var lega:FederationLeaguesData
    
    var body: some View {
        
        Form {

            Section(header: HeaderSectionSheetReverse(reverseSheet: $lega.creaLega))      {
                
                CustomToggleView(isActive: $lega.usaValoriDefault, testoTrue: "Disattiva Valori di Default", testoFalse: "Attiva Valori di Default")
                
                CampoTextView(nomeCampo: "Nome Lega:", placeholderCampo: "Ex: murphys 1", bindingCampo: $lega.nomeLega, isValueOk: lega.isNomeLegaOk)
              
                
    if !lega.usaValoriDefault {
                    
        Group {
            
                    CampoTextView(nomeCampo: "N° Squadre:", placeholderCampo: "default --> \(Default.partecipanti)", bindingCampo: $lega.numeroPartecipanti, isValueOk: lega.isPartecipantiOk)
                
                    CampoTextView(nomeCampo: "Budget:", placeholderCampo: "default --> \(Default.budget)", bindingCampo: $lega.budget, isValueOk: lega.isBudgetOk)
                    
                    CampoTextView(nomeCampo: "Portieri:", placeholderCampo: "default --> \(Default.portiere)", bindingCampo: $lega.distintaPortieri, isValueOk: lega.isPortieriOk)
                    
                    CampoTextView(nomeCampo: "Difesa:", placeholderCampo: "default --> \(Default.difesa)", bindingCampo: $lega.distintaDifesa, isValueOk: lega.isDifesaOk)
                    
                    CampoTextView(nomeCampo: "Cc:", placeholderCampo: "default --> \(Default.centrocampo)", bindingCampo: $lega.distintaCentrocampo, isValueOk: lega.isCentrocampoOk)
                    
                    CampoTextView(nomeCampo: "Attacco:", placeholderCampo: "default --> \(Default.attacco)", bindingCampo: $lega.distintaAttacco, isValueOk: lega.isAttaccoOk)
                    
        }.keyboardType(.numberPad)
                    
                } else {EmptyView()}

                
                if lega.isNomeLegaOk {
                    
                    if lega.usaValoriDefault {
                        
                        Button("Crea Lega"){
                            
                            lega.addNewLeague()
                            
                            lega.clean(all: false)
                            lega.creaLega.toggle()
                        }
                        
                    } else if lega.isAllDataOk {
                        
                        HStack{

                        Button("Imposta come Valori di Default"){
                            
                            Default.nuoviData(budget: lega.budget, partecipanti: lega.numeroPartecipanti, portiere: lega.distintaPortieri, difesa: lega.distintaDifesa, centrocampo: lega.distintaCentrocampo, attacco: lega.distintaAttacco);
                            
                            lega.isNuovoDefaultIn = true
               // Update da fare --> rendere l'impostazione dei nuovi default reversibile, o concludere previa conferma
                            
                        }
                            Spacer()
                            EmptyView()
                            
                        }.overlay(HStack {
                                    
        EmptyView()
        Spacer()
        lega.isNuovoDefaultIn ? Image(systemName:"checkmark.circle.fill").foregroundColor(.green) : Image(systemName: "checkmark.circle").foregroundColor(.secondary)})
                        
                        Button("Crea Lega"){
                            
                            lega.addNewLeague()
                            
                            lega.clean(all: true)
                            lega.creaLega.toggle()
                            lega.isNuovoDefaultIn = false
                        }
                    }
                }
            }
        }

    }
}

struct SetupLegaView_Previews: PreviewProvider {
    static var previews: some View {
        SetupLegaView(lega: FederationLeaguesData())
    }
}
