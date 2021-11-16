//
//  PrincipalTabView.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 25/06/21.
//

import SwiftUI

struct PrincipalTabView: View {

    @StateObject var leagueData: LeagueData
    
    var body: some View {
    
            TabView {
    
                TeamsSetupView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setup")
                    }.tag(0)
 
                if #available(iOS 15.0, *) {
                    ListaGiocatori()
                        .tabItem {
                            Image(systemName: "rectangle.stack.person.crop")
                            Text("Listone")
                        }.tag(1)
                    
                } else {
                    
                    ListaGiocatori_old()
                        .tabItem {
                            Image(systemName: "rectangle.stack.person.crop")
                            Text("ListoneOld")
                        }.tag(1)
                    
                    // Fallback on earlier versions
                }
                    
                ListaTeams()
                       .tabItem {
                           Image(systemName: "person.3")
                           Text("Partecipanti")
                       }.tag(2)
                
            }
         
            .navigationTitle(Text(leagueData.currentLeagueEntity.nomeLega ?? ""))
            .navigationBarBackButtonHidden(true)
            .environmentObject(leagueData)
  
        }
        
    }

/*
struct PrincipalTabView_Previews: PreviewProvider {
    static var previews: some View {
        
    PrincipalTabView(legaAttiva: LeagueModel(nome: "test"))
    //    PrincipalTabView()
    }
}
*/
