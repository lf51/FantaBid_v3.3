//
//  HeaderInfoBid.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 05/07/21.
//

import SwiftUI

struct HeaderInfoBid: View {
    
    @ObservedObject var leagueData: LeagueData
    var playerCorrente: PlayersModel
    
    @State var isFavoriteEntityCorrente: Bool = false

    var checkPlayer: Bool {check()}
    
    func setIsFavorite (){
        
        leagueData.addNewPlayerEntityFromHeaderInfoBid(id: playerCorrente.id, isFavorite: self.isFavoriteEntityCorrente)
    }
    
    func check() -> Bool {
        
        guard playerCorrente.id == playerCorrente.statistiche.stagione20s21.id &&
              playerCorrente.id == playerCorrente.statistiche.stagione19s20.id &&
              playerCorrente.id == playerCorrente.statistiche.stagione18s19.id &&
              playerCorrente.id == playerCorrente.statistiche.stagione17s18.id &&
              playerCorrente.id == playerCorrente.statistiche.stagione16s17.id &&
              playerCorrente.id == playerCorrente.statistiche.stagione15s16.id else { return false }
       
        return true
    }
    
    var body: some View {
        
        HStack{
            Text("\(playerCorrente.ruolo)")
                .frame(width: 25, height: 25)
                .background(playerCorrente.casaccaRuoloReparto.coloriDelRuolo)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        
            Text("\(playerCorrente.nome)")
                .bold()
              
            Image(systemName: isFavoriteEntityCorrente ? "bookmark.fill" : "bookmark")
                .font(.system(size: 14))
                .foregroundColor(isFavoriteEntityCorrente ? Color.blue : Color.secondary)
                .onTapGesture {
                    setIsFavorite()
                    isFavoriteEntityCorrente.toggle() // performare il tap senza usare bottone
            }
            
                Spacer()
                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .padding(.trailing,-4)
                .foregroundColor(checkPlayer ? .green : .secondary)//id check
            
                Text("\(playerCorrente.squadra)")
                    .foregroundColor(.secondary)
        
        }.onAppear {
            self.isFavoriteEntityCorrente = playerCorrente.isFavorite
        }

    }
}

/*

struct HeaderInfoBid_Previews: PreviewProvider {
    static var previews: some View {
        
   HeaderInfoBid(giocatore: PlayersData().lista21s22[0], playersData: PlayersData())
      
    }
}

 */
