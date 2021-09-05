//
//  ListaRow.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 22/06/21.
//

import SwiftUI

struct ListaRow: View {
    
    var giocatore:PlayersModel
    
    @Binding var astaMod:Bool
    
    var body: some View {
        
        HStack{
            
            HStack{giocatore.casaccaRuoloReparto.coloriSocialiCasacca}.frame(width: 40, height: 40).cornerRadius(10).padding([.leading,.trailing],2)//.shadow(color:.primary,radius: 2)
            
        
            Text("\(giocatore.ruolo)")
                .bold()
                .frame(width: 30, height: 30)
                .background(giocatore.casaccaRuoloReparto.coloriDelRuolo)
                .clipShape(Circle())
  
            VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/){
            
                HStack{
                    Text("\(giocatore.nome)").bold()
                    
                    Image(systemName: giocatore.isFavorite ? "bookmark.fill" : "bookmark").font(.system(size: 12)).foregroundColor(giocatore.isFavorite ? Color.blue : Color.clear).shadow(color:.primary,radius: 1.0)

                }
                
                Text("\(giocatore.squadra)").foregroundColor(.secondary)
            }
            
        
            Spacer()
            
        }.padding([.top,.bottom],10)
        .overlay(giocatore.svincolato && astaMod ? Text("Bid").bold().foregroundColor(Color.green) : Text("Info").bold().foregroundColor(Color.red),alignment: .trailing)
               
}
}

/*
struct ListaRow_Previews: PreviewProvider {
    static var giocatori = PlayersData().lista21s22
    
    static var previews: some View {
        Group{
            
            ListaRow(giocatore: giocatori[0],astaMod: .constant(true))
            ListaRow(giocatore: giocatori[300],astaMod: .constant(true))
            
    }//.environment(\.sizeCategory, .small)//.previewLayout(.fixed(width: 300, height: 70))
}
}
*/
