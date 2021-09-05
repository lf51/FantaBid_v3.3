//
//  TeamsRow.swift
//  Fantabid 4.0
//
//  Created by Calogero Friscia on 04/06/21.
//

import SwiftUI

struct TeamsRow: View {

    var teamData: TeamData
    
    var body: some View {
        
        HStack {
            
            teamData.casaccaTeam?.coloriSocialiRadiali.frame(width: 40, height:  40).cornerRadius(10).padding([.leading,.trailing],2)//.shadow(color:.primary,radius: 2) //RIPRISTINARE
            
            VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/){
            
                HStack{
                    Text(teamData.currentTeamEntity.nome ?? "").foregroundColor(teamData.currentTeamEntity.isPinned ? .blue : .primary).font(.system(.title3, design: .default)).bold()
                    Image(systemName: "pin.fill").foregroundColor(teamData.currentTeamEntity.isPinned ? .blue : .clear).scaledToFit()
                }

                Text(teamData.currentTeamEntity.fantaManager ?? "").foregroundColor(Color.secondary).font(.system(size: 15))
                
            }

            Spacer()
            Text("\(teamData.budgetCorrente)").bold().foregroundColor(.green)
           
        }.padding([.top,.bottom],5).cornerRadius(10)//.shadow(color:.primary,radius: 0.2)
       
    }
}

 /*
struct TeamsRow_Previews: PreviewProvider {
    static var previews: some View {
        TeamsRow(squadra: TeamsData().teams[0],teamsData: TeamsData())
    }
}
*/
