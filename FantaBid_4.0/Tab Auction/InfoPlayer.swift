//
//  InfoPlayer.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 22/06/21.
//

import SwiftUI

struct InfoPlayer: View {

    @ObservedObject var leagueData: LeagueData
    var playerCorrente: PlayersModel
   
    var sizeInfo:CGFloat = 15
    @State private var startedPlayerSelected: Bool = false
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Player Info")){
                
                HeaderInfoBid(leagueData: leagueData, playerCorrente: playerCorrente)
                
                HStack {
                    if playerCorrente.svincolato {
                        
                        VStack{
                            
                        Text("Status").font(.title3)
                        Text("svincolato").italic().foregroundColor(Color.secondary)
                        }
                        Spacer()
                            VStack{
                            
                        Text("Squadra").font(.title3)
                        Text("-").foregroundColor(Color.secondary)
                        
                        }
                        Spacer()
                            VStack{
                            
                        Text("Costo").font(.title3)
                        Text("-").foregroundColor(Color.secondary)
                        
                        }
                    } else {
                        
                        VStack {
                        
                    Text("Status").font(.title3)
                    Text("ceduto").italic()
                    
                    }
                    
                    Spacer()
                        VStack{
                    
                    Text("Squadra").font(.title3)
                    Text("\(playerCorrente.owner)").bold()
                    
                    }
                    Spacer()
                        VStack{
                        
                    Text("Costo").font(.title3)
                    Text("\(playerCorrente.costoCartellino)").bold().foregroundColor(Color.red)
                    
                    }
                    }
                }
            }
            
            Section(header: Text("Player Stat"),footer:Text("fonte dati Fantacalcio.it").italic()){
                
                VStack(alignment: .leading, spacing:5){
                  
                    Group {
                        
                    HStack {
                        Text("ST").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        Group{
                            Text("/16").bold()
                            Text("/17").bold()
                            Text("/18").bold()
                            Text("/19").bold()
                            Text("/20").bold()
                            Text("/21").bold()
                        
                        }.position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Text("/22").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                    }
                   
                    Divider().hidden()
                    
                    HStack {
                        
                        Text("Sq").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        Group{
                            Text("\(playerCorrente.statistiche.stagione15s16.siglaSquadra)")
                            Text("\(playerCorrente.statistiche.stagione16s17.siglaSquadra)")
                            Text("\(playerCorrente.statistiche.stagione17s18.siglaSquadra)")
                            Text("\(playerCorrente.statistiche.stagione18s19.siglaSquadra)")
                            Text("\(playerCorrente.statistiche.stagione19s20.siglaSquadra)")
                            Text("\(playerCorrente.statistiche.stagione20s21.siglaSquadra)")
                            
                        }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        Text("\(playerCorrente.siglaSquadra)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                    }
                        Divider().hidden()
                        Divider()
                        Divider().hidden()
                }
                    
                    Group{
                    HStack{
                        Text("Pg").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Group{
                            Text("\(playerCorrente.statistiche.stagione15s16.partiteGiocate)")
                            Text("\(playerCorrente.statistiche.stagione16s17.partiteGiocate)")
                            Text("\(playerCorrente.statistiche.stagione17s18.partiteGiocate)")
                            Text("\(playerCorrente.statistiche.stagione18s19.partiteGiocate)")
                            Text("\(playerCorrente.statistiche.stagione19s20.partiteGiocate)")
                            Text("\(playerCorrente.statistiche.stagione20s21.partiteGiocate)")
                        
                        }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        Text("\(playerCorrente.partiteGiocate)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("Mv").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Group{
                            Text("\(playerCorrente.statistiche.stagione15s16.mediaVoto)")
                            Text("\(playerCorrente.statistiche.stagione16s17.mediaVoto)")
                            Text("\(playerCorrente.statistiche.stagione17s18.mediaVoto)")
                            Text("\(playerCorrente.statistiche.stagione18s19.mediaVoto)")
                            Text("\(playerCorrente.statistiche.stagione19s20.mediaVoto)")
                            Text("\(playerCorrente.statistiche.stagione20s21.mediaVoto)")
                        
                        }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        Text("\(playerCorrente.mediaVoto)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    }
                    Divider()
                    
                    HStack{
                        Text("Mfv").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Group{
                            Text("\(playerCorrente.statistiche.stagione15s16.mediaFantaVoto)")
                            Text("\(playerCorrente.statistiche.stagione16s17.mediaFantaVoto)")
                            Text("\(playerCorrente.statistiche.stagione17s18.mediaFantaVoto)")
                            Text("\(playerCorrente.statistiche.stagione18s19.mediaFantaVoto)")
                            Text("\(playerCorrente.statistiche.stagione19s20.mediaFantaVoto)")
                            Text("\(playerCorrente.statistiche.stagione20s21.mediaFantaVoto)")
                        
                        }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        Text("\(playerCorrente.mediaFantaVoto)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    }
                        Divider().hidden()
                        Divider()
                        Divider().hidden()
                    }
                    if playerCorrente.ruolo == "P" {
                    Group {
                        
                        HStack{
                            Text("Gs").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            Group{
                                Text("\(playerCorrente.statistiche.stagione15s16.goalSubiti)")
                                Text("\(playerCorrente.statistiche.stagione16s17.goalSubiti)")
                                Text("\(playerCorrente.statistiche.stagione17s18.goalSubiti)")
                                Text("\(playerCorrente.statistiche.stagione18s19.goalSubiti)")
                                Text("\(playerCorrente.statistiche.stagione19s20.goalSubiti)")
                                Text("\(playerCorrente.statistiche.stagione20s21.goalSubiti)")
                            
                            }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            
                            Text("\(playerCorrente.goalSubiti)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        }
                        Divider().hidden()
                        Divider()
                        Divider().hidden()
                    }}else {}
                    
                    Group {
                        
                    HStack{
                        Text("Gf").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Group{
                            Text("\(playerCorrente.statistiche.stagione15s16.goalFatti)")
                            Text("\(playerCorrente.statistiche.stagione16s17.goalFatti)")
                            Text("\(playerCorrente.statistiche.stagione17s18.goalFatti)")
                            Text("\(playerCorrente.statistiche.stagione18s19.goalFatti)")
                            Text("\(playerCorrente.statistiche.stagione19s20.goalFatti)")
                            Text("\(playerCorrente.statistiche.stagione20s21.goalFatti)")
                        
                        }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        Text("\(playerCorrente.goalFatti)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    }
                        Divider()
                        
                        HStack{
                            Text("As").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Group{
                            Text("\(playerCorrente.statistiche.stagione15s16.assist)")
                            Text("\(playerCorrente.statistiche.stagione16s17.assist)")
                            Text("\(playerCorrente.statistiche.stagione17s18.assist)")
                            Text("\(playerCorrente.statistiche.stagione18s19.assist)")
                            Text("\(playerCorrente.statistiche.stagione19s20.assist)")
                            Text("\(playerCorrente.statistiche.stagione20s21.assist)")
                            
                            }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            
                            Text("\(playerCorrente.assist)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        }
                        Divider().hidden()
                        Divider()
                        Divider().hidden()
                    
                     
                    }
                    
                    Group {
                    
                            HStack{
                            Text("Am").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            Group{
                                Text("\(playerCorrente.statistiche.stagione15s16.ammonizioni)")
                                Text("\(playerCorrente.statistiche.stagione16s17.ammonizioni)")
                                Text("\(playerCorrente.statistiche.stagione17s18.ammonizioni)")
                                Text("\(playerCorrente.statistiche.stagione18s19.ammonizioni)")
                                Text("\(playerCorrente.statistiche.stagione19s20.ammonizioni)")
                                Text("\(playerCorrente.statistiche.stagione20s21.ammonizioni)")
                            
                            }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            
                            Text("\(playerCorrente.ammonizioni)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        }
                        Divider()
                            
                            HStack{
                                Text("Es").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                Group{
                                    Text("\(playerCorrente.statistiche.stagione15s16.espulsioni)")
                                    Text("\(playerCorrente.statistiche.stagione16s17.espulsioni)")
                                    Text("\(playerCorrente.statistiche.stagione17s18.espulsioni)")
                                    Text("\(playerCorrente.statistiche.stagione18s19.espulsioni)")
                                    Text("\(playerCorrente.statistiche.stagione19s20.espulsioni)")
                                    Text("\(playerCorrente.statistiche.stagione20s21.espulsioni)")
                                
                                }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                
                                Text("\(playerCorrente.espulsioni)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            }
                        Divider()
                        
                        HStack{
                            Text("Au").bold().position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Group{
                            Text("\(playerCorrente.statistiche.stagione15s16.autoGoal)")
                            Text("\(playerCorrente.statistiche.stagione16s17.autoGoal)")
                            Text("\(playerCorrente.statistiche.stagione17s18.autoGoal)")
                            Text("\(playerCorrente.statistiche.stagione18s19.autoGoal)")
                            Text("\(playerCorrente.statistiche.stagione19s20.autoGoal)")
                            Text("\(playerCorrente.statistiche.stagione20s21.autoGoal)")
                            
                            }.font(.system(size: sizeInfo)).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            
                            Text("\(playerCorrente.autoGoal)").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).position(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
                
            }
            
            if playerCorrente.svincolato{
                
                Button(action:
                        {
                            startedPlayerSelected.toggle()
                            leagueData.starterPlayer = startedPlayerSelected ? playerCorrente : nil
                            
                            
                        }, label: {
                    
                    HStack {

                        Image(systemName: "arrow.up.arrow.down").foregroundColor(.purple)
                        
                        if !startedPlayerSelected {
                            
                            Text("Inizia Asta \(playerCorrente.casaccaRuoloReparto.nomeDelReparto) da \(playerCorrente.nome)")
                            
                        } else {Text("Reimposta Ordine Asta").foregroundColor(.red) }
                        
                        
                        Spacer()
                    }
                })
            } else {EmptyView()}
           
        }.onAppear(perform: {
            startedPlayerSelected = leagueData.starterPlayer != nil
        })
        
    }
}
/*
struct InfoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        
 InfoPlayer(giocatore: PlayersData().lista21s22[0], playersData: PlayersData())
        
    }
}
*/


