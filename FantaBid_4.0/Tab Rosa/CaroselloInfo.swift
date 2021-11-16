//
//  testerView.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 05/08/21.
//


import SwiftUI

struct CaroselloInfo: View {

    var playerCorrente: PlayersModel
    @ObservedObject var teamData: TeamData
    
    var carosello: [String: Any] = [:]
    var caroselloKeys: [String] = ["PricePerPoint","PG", "MediaFV", "MediaVoto","Goal Subiti","Rigori Parati","Goal", "Assist", "Ammonizioni", "Espulsioni", "AutoGoal"]
    
    var caroselloOldTotalScore: [String: Float] = [:]
    let caroselloOldTotalScoreKeys: [String] = ["2020/21", "2019/20", "2018/19", "2017/18", "2016/17", "2015/16"]
    
    init(playerCorrente: PlayersModel, teamData: TeamData) {
        
        self.playerCorrente = playerCorrente
        self.teamData = teamData

        if self.playerCorrente.seasonalPlayerPPP == 0.0 || self.playerCorrente.seasonalPlayerPPP.isNaN || self.playerCorrente.seasonalPlayerPPP.isInfinite {
            
            carosello["PricePerPoint"] = 0.0
            
        } else {
            
            carosello["PricePerPoint"] = self.playerCorrente.seasonalPlayerPPP
        }
        
        carosello["PG"] = self.playerCorrente.partiteGiocate
        carosello["MediaFV"] = self.playerCorrente.NSStringMFV
        carosello["MediaVoto"] = self.playerCorrente.NSStringMV
        
        if playerCorrente.ruolo == "P" {
            
            carosello["Goal Subiti"] = self.playerCorrente.goalSubiti
            carosello["Rigori Parati"] = self.playerCorrente.rp
            
        } else {
            self.caroselloKeys.remove(at: 4)
            self.caroselloKeys.remove(at: 4)
            self.caroselloKeys.insert("Rigori Calciati", at: 4)
            carosello["Rigori Calciati"] = self.playerCorrente.rc
        }
        
        carosello["Goal"] = self.playerCorrente.goalFatti
        carosello["Assist"] = self.playerCorrente.assist
        carosello["Ammonizioni"] = self.playerCorrente.ammonizioni
        carosello["Espulsioni"] = self.playerCorrente.espulsioni
        carosello["AutoGoal"] = self.playerCorrente.autoGoal

        caroselloOldTotalScore["2020/21"] = self.playerCorrente.statistiche.stagione20s21.totalScore
        caroselloOldTotalScore["2019/20"] = self.playerCorrente.statistiche.stagione19s20.totalScore
        caroselloOldTotalScore["2018/19"] = self.playerCorrente.statistiche.stagione18s19.totalScore
        caroselloOldTotalScore["2017/18"] = self.playerCorrente.statistiche.stagione17s18.totalScore
        caroselloOldTotalScore["2016/17"] = self.playerCorrente.statistiche.stagione16s17.totalScore
        caroselloOldTotalScore["2015/16"] = self.playerCorrente.statistiche.stagione15s16.totalScore
        
    }
    
    @State var isPlayerSvincolato: Bool = false
    
    
    var body: some View{
        
        VStack {
            
            ZStack{
                
               Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height:100)
                .cornerRadius(15.0)
                .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
              //  .shadow(color:.primary,radius: 5.0)
                
                HeaderNewInfo(playerCorrente: playerCorrente)
                    .frame(maxWidth: .infinity)
                    .padding()
                
            }.padding(.top)
            
        
            ZStack {
                Rectangle()
                    .cornerRadius(10.0)
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                   // .shadow(color: .primary, radius: 5.0)
                
                Text("Stagione in Corso 2021/22")
                    .bold()
                    .padding()
            }

            ScrollView(.horizontal) {
      
                    HStack(alignment:.top) {
                        
                        ForEach(caroselloKeys, id:\.self) { key in

                            ZStack {
                                    
                                    Rectangle()
                                        .cornerRadius(20.0)
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                                      //  .shadow(color:.primary,radius: 5.0)
                                    
                                    VStack {

                                        Text("\(key)")
                                            .bold()
                                            .padding(.top)
                                            .padding(.horizontal)
                                            .frame(width: 150)
                                        
                                        Text("\((carosello[key] as? NSObject)!)")
                                            .bold()
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .padding()
 
                                       Spacer()
                                    }
                                  
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                        }
                    }
                
            }
            
            ZStack {
                
                Rectangle()
                    .cornerRadius(10.0)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)))
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                  //  .shadow(color: .primary, radius: 5.0)
                
                Text("Partite Giocate x MediaFV")
                    .bold()
                    .padding()
                    
            }
           
            ScrollView(.horizontal) {
      
                    HStack(alignment:.top) {
                        
                        ForEach(caroselloOldTotalScoreKeys, id:\.self) { key in
                                
                                ZStack {
                                    
                                    Rectangle()
                                        .cornerRadius(20.0)
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)))
                                       // .shadow(color:.primary,radius: 5.0)
                                    
                                    VStack {
                                        
                                        Text("\(key)")
                                            .bold()
                                            .padding(.top)
                                            .padding(.horizontal)
                                            .frame(width: 150)
                                        
                                        Text("\(caroselloOldTotalScore[key] ?? 0.0)")
                                            .bold()
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .padding()
                                            
                                        
                                       Spacer()
                                    }
                                  
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                        }
                    }
                
            }
            
            HStack {
                Text("fonte dati Fantacalcio.it").font(.system(size: 14)).foregroundColor(.secondary).italic()
                Spacer()
            }
            
            Spacer()
            
            if !isPlayerSvincolato {
                
                Menu {
                    
                    Button(action: {},
                           label: {Text("Annulla")})
                    
                    Button(action: {
                        
                        teamData.svincolaPlayerEntity(playerModel: playerCorrente)
                        self.isPlayerSvincolato.toggle()
                        
                    }, label: {
                        
                            Text("Conferma")
             
                    })
  
                } label: {
                    
                    Text("Svincola").foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(color:.primary,radius: 2)
                        .padding()
            }
            
            } else {
                Text("Il giocatore \(playerCorrente.nome) è ora libero.").italic().foregroundColor(.secondary)
            }
          
        }.padding()
        
    }
}


