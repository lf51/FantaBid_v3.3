//
//  ListaTeams.swift
//  Fantabid 4.0
//
//  Created by Calogero Friscia on 04/06/21.
//

import SwiftUI

//@available(iOS 15.0, *)
struct ListaTeams: View {

    @EnvironmentObject var leagueData: LeagueData
  //  @Environment(\.presentationMode) var presentationMode
  //  @Environment(\.isPresented) var isPresented

    var body: some View {
    
        VStack {

            if leagueData.currentLeagueEntity.isListaConfermata {
                
                List {
                    
                    ForEach(leagueData.elencoTeamsData.sorted(by: {($0.currentTeamEntity.isPinned.description, $0.budgetCorrente) > ($1.currentTeamEntity.isPinned.description, $1.budgetCorrente)})){ teamData in

                        NavigationLink(
                                destination: RosaView(teamData: teamData)){
                            TeamsRow(teamData: teamData)
                            }
                    }
                    
                }
       
            } else {Text("Lista Partecipanti non confermata").italic()}

        }

}
}

/*
struct ListaTeams_Previews: PreviewProvider {
    static var previews: some View {
    
      /* ListaTeams(listateams: TeamsData(),playerData: PlayersData())*/
        ListaTeams().environmentObject(TeamsData()).environmentObject(PlayersData())
    }
}

*/
