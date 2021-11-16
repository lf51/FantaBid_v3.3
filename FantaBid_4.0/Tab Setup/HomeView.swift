//
//  HomeView.swift
//  FantaBid 4.0
//
//  Created by Calogero Friscia on 21/06/21.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var federationLeaguesData: FederationLeaguesData
    @State var offset:CGSize = .zero
    @State var showDeleteButton: Bool = false
    
    var body: some View {
        
        NavigationView {

            VStack(alignment:.leading) {
                               
                HStack {
                    Label {
                                Text("Elenco Leghe Attive: \(federationLeaguesData.elencoLeghe.count)")
                            } icon: {
                                Image(systemName: "list.bullet")
                            }.font(.system(size: 15))
                    .padding()
                    Spacer()
                }
              
                        ScrollView{
                            
                            ForEach(federationLeaguesData.elencoLeghe){ league in
                               
                                NavigationLink(
                                    destination: PrincipalTabView(leagueData: LeagueData(legaRiferimento: league))) {
                                    
                                    HStack {
                                        MyListView(isComplete: league.isListaConfermata, testoB: league.nomeLega ?? "", testoC: league.numeroPartecipanti ?? "0", imageName: "person.3")
                                            //.padding(.top, 1)
                                       // quando la lista è confermata, l'info non è aggiornata in tempo reale. Occorre uscire e rientrare per vedere il bollino verde nella lista Leghe. Problem da risolvere ma non Urgente.
                                      
                                        if showDeleteButton {
                                        
                                    
                                                Button(action: {
                                                 withAnimation(.easeInOut(duration: 1.0)) {
                                                             federationLeaguesData.deleteLeague(leagueEntity: league)
                                                         }
                                                         }, label: {
                                                           
                                                                Image(systemName: "trash")
                                                                    .frame(width: 50, height: 50, alignment: .center)
                                                                    .foregroundColor(.white)
                                                                    .background(Color.red)
                                                                    .cornerRadius(10)
                                                                    .shadow(radius: 2)
                                                                    .padding(.trailing)
                                                            
                                                             
                                                         })
                                            
                                        } else {EmptyView()}
                                        
                                    }.padding(.bottom, 0.1)
                                    
                   
                                }
                            
                            }//.listRowBackground(Color.yellow) // non funziona perchè il forEache è dentro una scrollView e non una list
                            
                        
                        }.toolbar(content: {
                            
                            HStack() {
                                
                                Button(action: {
                                    
                                    self.showDeleteButton = false
                                    federationLeaguesData.creaLega.toggle()
                                    
                                }, label: {
                                    Image(systemName: "plus").padding(.horizontal)
                                })
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                            showDeleteButton.toggle()
                                        }
                                        }, label: {
                                            Text(showDeleteButton ? "Done" : "Edit").fontWeight(.bold)
                                    })
                            }
                        })
   
            }.sheet(isPresented: $federationLeaguesData.creaLega, content: {
                SetupLegaView(lega: federationLeaguesData)
            })
            .onAppear(perform: {
                self.showDeleteButton = false
            })
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle(Text(federationLeaguesData.elencoLeghe.isEmpty ? "Add New Leagues" : "All Leagues"))
            
            
        }//.navigationViewStyle(StackNavigationViewStyle())
        //.navigationViewStyle(.stack)
}
}
/*
struct BetaHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(federationLeaguesData: FederationLeaguesData())
    }
}
*/
