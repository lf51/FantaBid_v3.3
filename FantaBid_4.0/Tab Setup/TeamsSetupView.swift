//
//  CustomTeams.swift
//  Fantabid 4.0
//
//  Created by Calogero Friscia on 02/06/21.
//

import SwiftUI

struct TemporaryTeamModel: Hashable {
    
    var id = ""
    var nome = ""
    var fantaManager = ""
}

struct TeamsSetupView: View {
    
    @EnvironmentObject var leagueData: LeagueData
    @Environment(\.presentationMode) var presentationMode

    @State var goEditing = false
    @State var editingTeamName = ""
    @State var editingManager = ""

    var body: some View {
        
        VStack {
            
        Form { // il form impedisce all'animazione di funzionare. Dobbiamo eliminare il form e rielaborare la View
      
                Section(header: HStack {
                    Text("Setup Lega")
                    Spacer()
                    Button(action: {presentationMode.wrappedValue.dismiss()},
                    label:{
                        HStack{
                            Image(systemName: "eject")
                            Text("Exit")
                            
                        }.foregroundColor(.red)
                        
                    } )
            
                }.padding(.horizontal)

                ) {
                    Group {

                    CampoTextView(placeholderCampo: "nome squadra", bindingCampo: $leagueData.customTeamName, isValueOk: leagueData.isCustomNameOk)
            
                    CampoTextView(placeholderCampo: "nome manager", bindingCampo: $leagueData.customTeamFantaManager, isValueOk: leagueData.isCustomManagerOk)
                        
                    }.disabled(leagueData.checkTemporaryCount || leagueData.checkEntityCount)
                
                    if leagueData.emptyField {
                        HStack{
                            
                            Image(systemName: "multiply.circle.fill").foregroundColor(.red)
                            Text("Compila tutti i campi").italic().foregroundColor(.secondary)
                        }
                        
                    }
                    
                    if leagueData.foundTeamNameDuplicate || leagueData.foundTeamManagerDuplicate {
                        
                        HStack{
                            
                            Image(systemName: "multiply.circle.fill").foregroundColor(.red)
                            Text("Valore già esistente").italic().foregroundColor(.secondary)
                        }
                        
                    }
                    
                    
                    if !leagueData.checkTemporaryCount && !leagueData.checkEntityCount {
                        
                        Button(action: {
                             //   teamsData.addNewTeam(legaRiferimento: leagueEntity)
                            
                            leagueData.addNewTemporaryTeam()
                        },
                               
                               label: {
                            HStack{
                                Spacer()
                                Text("Crea Squadra")
                                Spacer()
                                
                            }
                        })
     
                        
                    } else { HStack {
                        
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            .padding(.trailing,5)
                        
                        Text("Lista squadre Completa").foregroundColor(.secondary).font(.system(.subheadline, design: .monospaced)).animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                    }
                    }
               }

            if !leagueData.temporaryTeamList.isEmpty || !leagueData.elencoTeamsEntity.isEmpty {

                    Section(header:
                                    HStack{
                                        Text(leagueData.currentLeagueEntity.isListaConfermata ? "Squadre: \(leagueData.currentLeagueEntity.partecipantiLega?.count ?? 0) / \(leagueData.numeroPartecipanti)" : "Squadre: \(leagueData.temporaryTeamList.count) / \(leagueData.numeroPartecipanti)")//.padding(.leading, 2)
                                        Spacer()
                                        Text("Giocatori: \(leagueData.currentLeagueEntity.giocatoriTrasferiti?.count ?? 0) / \(leagueData.totaleGiocatoriDaTrasferireInLega)")
                                        
                                    }.padding(.horizontal)
                                    ) {
                        
                            if !leagueData.currentLeagueEntity.isListaConfermata {

                                    List {
                                            
                                            ForEach(leagueData.temporaryTeamList, id:\.self) { temporaryTeamModel in
                                                 
                                                    HStack {
                                                        Image(systemName: "circlebadge.fill").foregroundColor(.secondary).padding(.trailing)
                                                        Text(temporaryTeamModel.nome)
                                                            Spacer()
                                                            Image(systemName: "person").foregroundColor(.secondary)
                                                        Text(temporaryTeamModel.fantaManager)//.padding(.trailing)
                                        
                                                    }

                                            }.onDelete { indexSet in
                                                
                                                        leagueData.removeTemporaryTeam(index: indexSet)
                                                
                                                    }
                                            
                                    }//.animation(Animation.linear) // l'animazione per funzionare vuole ScrollView al posto di List. Ma con la scrollView non funziona il delete :-(
  
                            } else {
                                
                              ForEach(leagueData.elencoTeamsEntity, id: \.self) { team in
                                  
                                    HStack {
                                        HStack {
                                        Button {
                                            withAnimation(.easeInOut(duration: 1.0)) {
                                                leagueData.resetAllPin(teamEntity: team)
                                            }
           
                                        } label: {
                                            
                                            Image(systemName: team.isPinned ? "pin.fill" : "pin").foregroundColor(team.isPinned ? .green : .secondary)
                                        }
                                        }.padding(.trailing).disabled(goEditing)
                 
                                        if editingTeamName != team.nome ?? "" {
                                                
                                                Text(team.nome ?? "").onTapGesture {
                                                    
                                                    self.editingTeamName = team.nome ?? ""
                                                    self.editingManager = ""
                                                    self.goEditing = true
                                                }
                                                
                                            } else {

                                                TextField(team.nome ?? "", text: $leagueData.customTeamNameUpdate) { change in
                                                    
                                                    self.goEditing = change
                                                    if !change {
                               
                                                    self.editingTeamName = "" ;}
                                                    
                                                        } onCommit:{
                                                leagueData.updateTeamData(teamEntity: team, trueXnomeFalseXmanager: true) }
    // non funziona benissimo, richiede si prema Enter per salvare i dati. Da performare meglio
                                            }
                             
                                        Spacer()
                            
                                        if editingManager != team.fantaManager ?? ""  {
                                            
                                            Text(team.fantaManager ?? "").onTapGesture {
                                                
                                                self.editingManager = team.fantaManager ?? ""
                                                self.editingTeamName = ""
                                                self.goEditing = true
                                                
                                            }
                                            
                                        } else {
                                            
                                    TextField(team.fantaManager ?? "", text: $leagueData.customTeamFantaManagerUpdate) { change in
                                                
                                                self.goEditing = change
                                        
                                        if !change {
                   
                                        self.editingManager = "" ;}
                                                
                                        } onCommit:{
                                            leagueData.updateTeamData(teamEntity: team, trueXnomeFalseXmanager: false) }
                                    
                                        .fixedSize(horizontal: true, vertical: true)

                                }
                                      
                                        Image(systemName: "person").foregroundColor(.secondary)
                                     
                                    }
                                }

                            }
                     
                            if leagueData.checkTemporaryCount || leagueData.checkEntityCount {
                              //  Section{
                                    
                                if !leagueData.currentLeagueEntity.isListaConfermata {
                                    
                                    Button (
                                        action: {
                                            
                                            leagueData.confermaLista()
                                            
                                        },
                                        label: {
                                            HStack{
                                                Spacer()
                                                Text("Conferma Lista")
                                                Spacer()
                                                
                                            }
                                         }
                                    )
                                    
                                    } else {
                                        
                                        Text("Partecipanti lega caricati. Modalità Asta Attiva").foregroundColor(.secondary).italic()
                                        
                                    }

                            }
                    }

                } else {EmptyView()}
  
      }
       
            
        }
  
        
    }

}
/*
struct BetaTeamsSetupView_Previews: PreviewProvider {
    static var previews: some View {
     
      BetaTeamsSetupView(legaAttiva: LeagueModel(nome: "test")).environmentObject(TeamsData())
        
       // BetaTeamsSetupView(legaAttiva: LeagueModel(nome: "Test"))
 }
}
*/
