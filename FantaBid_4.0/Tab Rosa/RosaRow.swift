//
//  ListaRow.swift
//  Fantabid 4.0
//
//  Created by Calogero Friscia on 30/05/21.
//

import SwiftUI

struct RosaRow: View {
    
  var giocatore: PlayersModel
    
    var body: some View {
        
        HStack{
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)){
                Text("\(giocatore.siglaSquadra)").bold().zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/).font(.system(.subheadline, design: .monospaced))/*.shadow(color: .primary,radius:1)*/.foregroundColor(.gray).contrast(10)

                HStack{giocatore.casaccaRuoloReparto.coloriSocialiCasacca}.frame(width: 40, height: 30).cornerRadius(10).padding([.leading,.trailing],2).shadow(color:.primary,radius: 2)
            }
        
            HStack{
                    Text("\(giocatore.nome)").bold()
                
                Spacer()

                  Text("\(giocatore.costoCartellino)").bold().multilineTextAlignment(.trailing).foregroundColor(Color.orange)
                  Image(systemName: "dollarsign.circle").foregroundColor(.secondary).padding(.leading,-5)

                 Text("-")
                 Text("Info").bold().font(.system(.subheadline, design: .monospaced)).textCase(.uppercase).padding(.trailing,10).foregroundColor(.red)
                    
                }
          
        }.padding([.top,.bottom],3).cornerRadius(10)//.shadow(color:.primary,radius: 0.2)
       
    }
}

/*
struct RosaRow_Previews: PreviewProvider {
    static var giocatori = PlayersData().lista21s22
    
    static var previews: some View {
        Group{
            
        RosaRow(giocatore: giocatori[20])
        RosaRow(giocatore: giocatori[0])
            
    }//.previewLayout(.fixed(width: 300, height: 70))
}
}
*/
