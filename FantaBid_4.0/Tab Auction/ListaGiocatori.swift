//
//  ListoneGiocatori.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 22/06/21.
//


import SwiftUI

struct ListaGiocatori: View {

    @EnvironmentObject var leagueData: LeagueData
    @Environment(\.presentationMode) var presentationMode

    @State private var astaMod:Bool = false
    @State private var searchText: String = ""
    @State private var selectedReparto: Reparto = Reparto.All
    
    var showFavoriteOnly:Bool {selectedReparto == Reparto.Opzionati}
    var repartoAllActives:Bool {selectedReparto == Reparto.All || selectedReparto == Reparto.Opzionati }
    
    var repartoPicked:[Reparto] {
    
        var array:[Reparto] = []
        
        if repartoAllActives {
            
            array = [Reparto.Portieri, Reparto.Difesa, Reparto.Centrocampo, Reparto.Attacco]
            
        } else {
            
            array = [selectedReparto]
        }
        
        return array
        
    }
    
    var body: some View {
        
        VStack {
            
            List {
                
                SearchBar(text: $searchText, placeholder: "Search Player...")//.padding(.vertical, -10)

                if leagueData.currentLeagueEntity.isListaConfermata {
                    
                        CustomToggleView(isActive: $astaMod, testoTrue: "Esci da Modalità Asta", testoFalse: "Attiva Modalità Asta")
                    
                } else {Text("Modalità Asta non disponibile - Lista Partecipanti incompleta").foregroundColor(.secondary).italic()}
                
                
               Picker("Reparto", selection: $selectedReparto) {
                    Text("All")
                        .tag(Reparto.All)
                Image(systemName: "bookmark.fill")
                        .tag(Reparto.Opzionati)
                    Text("P")
                        .tag(Reparto.Portieri)
                    Text("D")
                        .tag(Reparto.Difesa)
                    Text("C")
                        .tag(Reparto.Centrocampo)
                    Text("A")
                        .tag(Reparto.Attacco)
                }.pickerStyle(SegmentedPickerStyle())

                ForEach(repartoPicked, id:\.self) {reparto in
                    
                    Section(header:Text(reparto.rawValue)) {
                        
                        ForEach(leagueData.currentPlayersData.listaFiltrata(reparto: reparto.rawValue, showFavoriteOnly: showFavoriteOnly, searchText: searchText, isPresented: presentationMode.wrappedValue.isPresented, startFrom: leagueData.starterPlayer ?? nil, repartoAllActives: repartoAllActives)){ player in
                            
                            if  player.svincolato && astaMod {
                                
                                NavigationLink(destination: BidView(leagueData: leagueData, playerCorrente: player)){ListaRow(giocatore: player, astaMod: $astaMod)}

       } else {
                                
        NavigationLink(destination: InfoPlayer(leagueData: leagueData, playerCorrente: player)){ListaRow(giocatore: player, astaMod: $astaMod)}
                            }
                        }
                    }
                }
            }
            
        }
        
    }
}
          
/*

struct ListaGiocatori_Previews: PreviewProvider {
    static var previews: some View {
        
        ListaGiocatori().environmentObject(TeamsData()).environmentObject(PlayersData())
    }
}

*/
