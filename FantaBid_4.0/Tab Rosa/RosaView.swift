//
//  RosaView.swift
//  Fantabid 4.0
//
//  Created by Calogero Friscia on 04/06/21.
//

import SwiftUI

struct RosaView: View {

    @ObservedObject var teamData: TeamData
    
    var reparto:[String] {teamData.distinta.keys.sorted{$0 > $1}}
    
    var body: some View {

            
            Form {
                
          List {
                
            ForEach(reparto, id:\.self) { reparto in
                
        Section(header:HStack {
            
            Text("\(reparto)").padding(.leading,10)
            Spacer()
            Text("Spesa:")
           Text("\(teamData.costoReparto(reparto: reparto))").bold().font(.subheadline).padding(.trailing,10)}) {
                    
            ForEach(teamData.distinta[reparto]!, id:\.self) { player in
                
                NavigationLink(destination: CaroselloInfo(playerCorrente: player, teamData: teamData),label: {RosaRow(giocatore: player)})
                        
            }
                }
           }
        }
                
            }.navigationBarTitle(teamData.currentTeamEntity.nome ?? "")
        }
}


/*
struct RosaView_Previews: PreviewProvider {
    static var previews: some View {
        
  RosaView(squadra: TeamsData().teams[0],playersData: PlayersData())
        
        /*RosaView(squadra: TeamsData()).environmentObject(TeamsData()).environmentObject(PlayersData())*/
    }
}

*/
