//
//  BidView.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 05/07/21.
//

import SwiftUI

struct BidView: View {
   
    @ObservedObject var leagueData: LeagueData
    var playerCorrente: PlayersModel //necessario

    @State private var bid: String = ""
    
    @State private var isSelling = false
    @State private var isSelled = false
    
    @State private var temporaryOwner: TeamEntity?
    @State private var temporaryLocalTeamData: TeamData?
    @State private var valoreBid: Int = 0
    
    @State private var animationAmount: CGFloat = 1
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var finishedText: String? = nil
    @State var count: Int = 3
    
    func checkAuction(localTeamData: TeamData) {

        let localBid = self.bid
        self.bid = ""
        
    guard let valoreBid = Int(localBid) else { return}
    guard valoreBid > 0 else {return}
    guard
        localTeamData.checkRosa(ruoloGiocatore: playerCorrente.ruolo, bid: valoreBid) else {return}
   
            isSelling = true

      temporaryOwner = localTeamData.currentTeamEntity
      temporaryLocalTeamData = localTeamData
      self.valoreBid = valoreBid

    }
    
    func goAuction(localTeamData: TeamData) {
   
        localTeamData.addNewPlayerEntity(id: playerCorrente.id, costo: self.valoreBid)
        
        //updateAlgoritmo
        leagueData.currentPlayersData.algoritmoData.updatePPPValue(playerCorrente: playerCorrente, lastBid: self.valoreBid)
       
        isSelled = true
        print("Entity Giocatore Assegnata")
    }
  
    func resetAuction () {
        
    isSelling = false
    count = 3
        
    }
    
    func bidding(bid:Int) {
        
        guard !isSelling && !isSelled else {return}
  
        let valoreBid = Int(self.bid) ?? 0
        
        var currentBid = valoreBid
        currentBid += bid
        
        if currentBid > 0 {self.bid = String(currentBid)} else {self.bid = ""}
    
    }
    
    func hideKeyboard(){
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    var body: some View {
  
            Form {
              
                Section(header: Text("Player in Auction"),footer:Text("fonte dati Fantacalcio.it").italic()){
                    
                    HeaderInfoBid(leagueData: leagueData, playerCorrente: playerCorrente)
   
                    SubHeaderBidView(playerCorrente: playerCorrente, animationAmount: $animationAmount)
                    
                }
                
                Group {
                    
                    Section(header: Text(!isSelling ? "Bid" : "Bidder")){
                    
                    if !isSelling {
                        
                        HStack {
                            TextField("0", text: $bid)
                                .keyboardType(.numberPad)
                                .frame(maxWidth: .infinity)
                                .frame(height: 125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .font(.system(size: 100))
                            
                            VStack {
                                Spacer()
                                Text("pip < \(leagueData.currentPlayersData.algoritmoData.choosePpp(playerRuolo: playerCorrente.ruolo) * playerCorrente.statistiche.stagione20s21.totalScore)").foregroundColor(.secondary)
  
                            }
                                
                        }
                                                
                    }
                    
                    else {
                        
                        HStack{
                            
                            VStack {
                            Text("\(temporaryOwner!.nome ?? "") per \(valoreBid) crediti").italic().foregroundColor(Color.secondary)
                            }
                            
                            
                        Spacer()
                            
                            if let isFinished = finishedText {
                                
                                Image(systemName: isFinished)
                                    .font(.system(size: 100))
                                    .foregroundColor(.green)
                                
                            } else {
                                Text("\(count)")
                                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                                    .foregroundColor(.red)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                            }
                           
                            Spacer()
                            
                            if count != 0 {
                            
                            VStack(spacing: 20) {

                                Button(action: {resetAuction()}, label: {
                                    Text("UNDO").bold().font(.system(.subheadline, design: .monospaced)).foregroundColor(.red)
                                }).frame(width: 50, height: 35, alignment: .center).background(Color.init(red: 205, green: 205, blue: 205)).cornerRadius(5.0).shadow(radius: 1.0)
                                
                            }
                                
                            } else {EmptyView()}
                       
                        }.frame(maxWidth: .infinity)
                        .frame(height: 125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .onReceive(timer, perform: { _ in
                            
                            if count == 0 && !isSelled {
                                
                                finishedText = "hand.thumbsup.fill"
                                goAuction(localTeamData: temporaryLocalTeamData!)
                                
                            } else if isSelling && !isSelled {count -= 1}
                            
                        })
                        
                    }
                        
                        HStack {
 
                            Group {
                                
                                HStack {
                 
                                    Text("-1 / C").bold().foregroundColor(.red).onTapGesture {
                                            bidding(bid: -1)
                                       hideKeyboard()
                                        }.onLongPressGesture {
                                            self.bid = ""
                                            hideKeyboard()
                                        }.padding(.horizontal)
                                }
                                
                                Spacer()
                                Divider()
                                Spacer()
                                
                                HStack {
          
                                    Text("+ 10").font(.title3).foregroundColor(Color(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))).bold().onTapGesture {
                                            bidding(bid: 10)
                                        hideKeyboard()
                                        }.padding(.horizontal)
                       
                                }
                                
                            }
                  
                            Group {
                                
                                Spacer()
                                Divider()
                                Spacer()
                                
                                HStack {
                                    
                                    Text("+ 5").font(.headline).foregroundColor(Color(#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1))).bold().onTapGesture {
                                        bidding(bid: 5)
                                        hideKeyboard()
                                    }.padding(.horizontal)
      
                                }
                                
                                Spacer()
                                Divider()
                                Spacer()
                                
                                HStack {

                                    Text("+ 1").font(.none).foregroundColor(.green).bold().onTapGesture {
                                        bidding(bid: 1)
                                        hideKeyboard()
                                    }.padding(.horizontal)
                                    
                            }
                            }

                        }//.disabled(isSelling || isSelled)
                 
                    }
                }
      
                Section(header:Text("Bidder")){

                    List {
                        
                        ScrollView {
                            
                        ForEach(leagueData.elencoTeamsData.sorted(by: {$0.budgetCorrente > $1.budgetCorrente})) { localTeamData in
                                
                                
                            let check: Bool = localTeamData.checkReparto(player: playerCorrente)
                                
                            VStack {
                                
                                Button(action: {
                                        checkAuction(localTeamData: localTeamData)
                                    
                                },
                                       label: {
                                        HStack{
                                            Image(systemName: "checkmark")
                                                .frame(width: 25, height: 25).foregroundColor(check ? .green : .clear).background(Color.yellow).cornerRadius(7).padding(.trailing,5)
                                                
                                                VStack(alignment: .leading){

                                                    Text(localTeamData.currentTeamEntity.nome ?? "")
                                                    
                                                    Text(localTeamData.currentTeamEntity.fantaManager ?? "").foregroundColor(.secondary)
                                                    
                                                }
                                                
                                            if localTeamData.currentTeamEntity.isPinned {
                                                    
                                                    Image(systemName: "pin.fill").foregroundColor(.green)
                                                    
                                                }
               
                                                Spacer()
                                                
                                                VStack(alignment: .trailing){
                                                    localTeamData.budgetProgression()
                                                    localTeamData.repartoCount(player: playerCorrente)
                                                }
                                        }.opacity(check ? 0.8 : 1.0).blur(radius: check ? 1.1 : 0)
                                       }).disabled(isSelling || isSelled)
                             
                                Divider()
                            }
                                
                        }
                            
                        }.animation(Animation.easeIn(duration: 1.0))
                    }
                            
                            }
      
            }.navigationTitle("\(playerCorrente.nome)").navigationBarTitleDisplayMode(.inline)
                    
            }
    }
          
            
 
/*
struct BidView_Previews: PreviewProvider {
 
    static var previews: some View {
        
      BidView(giocatore: PlayersData().lista21s22[1],teamsData:TeamsData(),playersData: PlayersData())
       
       
    }
}
*/

/* COSA SAPPIAMO :
 1. con la doppia scrittura, la funzione assegna i cambiamenti al player e assegna il giocatore alla squadra. con la doppia scrittura funziona tutto.
 2. se eliminiamo la doppia scrittura, andiamo in crash. l'assegnazione del giocatore alla squadra non funziona piu'.
 
 3. se nel listone eliminiamo l'if che comanda lo swicht fra bid e info, la bidview viene aggiornata istantaneamente quando assegniamo il giocatore, ma persiste il crash sull'assegnazione.
 
 4. Il check reparto non funziona più.
 
 5. Siamo riusciti ad eliminare i comandi doppi nell'assegnazione, funziona tutto, tranne il check reparto.
 
 --> Next step RISCRIVERE la BIDVIEW con più ordine. Mettere tutti i metodi dentro un altro oggetto.
 
 
 6. il team.teamIndex è un modo inefficente di indicizzare e recuperare la squadra, perchè quando inseriremo la possibilità di eliminare una squadra esistente si creeranno dei disallineamenti fra l'id e l'index che farà cambiare i valori in una squadra diversa(nel migliore delle ipotesi)
 
 ----> !!!!UPDATE!!!!! 07/07/2021 <---------
 
 1. nella bidView abbiamo messo lo StateObject al playersData (funziona anche con l'observed) e nell'headerInfoBid abbiamo messo l'observed sempre sul playersData.
 In questo modo la bidView si aggiorna instant, nonostante l'if (che faceva saltare tutto) nella ListaGiocatori.
 
 Permane il dilemma:
 
 PERCHE' l'InfoPlayer aggiorna Instant senza la necessità di un observed nel suo playersData e nell'headerInfoBid, mentre la bidView senza l'observed non aggiornaInstant.
 
 2. Nella bidView abbiamo cercato di ragionare sui Value e i reference Type, rendendoci conto che tante volte passiamo oggetti per copia e per questo motivo ci sono incongruenze. Quindi abbiamo cercato di risolvere tali incongruenze utilizzando gli indici per recuperare il valore originale dentro le liste e usare questo per la modifica e la lettura di dati. LO abbiamo fatto anche per la squadra nella ListaTeam e nel TeamRow
 
 */
