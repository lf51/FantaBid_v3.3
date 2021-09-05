//
//  TeamData.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 22/08/21.
//

import Foundation

//import Combine
import CoreData
import SwiftUI

// Questo TeamData nasce dallo scorpore del vecchio TeamsData in LeagueData e TeamData appunto. Qui gestiamo il singolo Team, ossia la creazione di un elenco di Giocatori

final class TeamData: ObservableObject, Identifiable {
    
    let manager = CoreDataManager.instance

    var currentTeamEntity: TeamEntity
    var leaguePlayersData: PlayersData
    
    @Published var playerEntityTesserati: [PlayerEntity] = []
  
    var playerModelTesserati: [PlayersModel] {
       
        var elencoModelTesserati: [PlayersModel] = []
        
        guard !playerEntityTesserati.isEmpty else {return elencoModelTesserati }
            
            for playerEntity in playerEntityTesserati {
                
                let id = playerEntity.id
                
                if let tesserato = self.leaguePlayersData.lista21s22.first(where: {$0.id == Int(id ?? "0")}) {
                    
                    elencoModelTesserati.append(tesserato)
                }
            }
        print("New elencoModelTesserati compilato")
        return elencoModelTesserati
        
            }
    
            
   init(teamEntity: TeamEntity, playersData: PlayersData) {
 
    self.currentTeamEntity = teamEntity
    self.leaguePlayersData = playersData
    
    self.budgetFromLega = Int(self.currentTeamEntity.legaRiferimento?.budget ?? "0") ?? 0
    
    self.distintaPortieri = Int(self.currentTeamEntity.legaRiferimento?.distintaPortieri ?? "0") ?? 0
    self.distintaDifesa = Int(self.currentTeamEntity.legaRiferimento?.distintaDifesa ?? "0") ?? 0
    self.distintaCentrocampo = Int(self.currentTeamEntity.legaRiferimento?.distintaCentrocampo ?? "0") ?? 0
    self.distintaAttacco = Int(self.currentTeamEntity.legaRiferimento?.distintaAttacco ?? "0") ?? 0
    
    self.numeroPartecipanti = Int(self.currentTeamEntity.legaRiferimento?.numeroPartecipanti ?? "0") ?? 0
    
    casaccaTeam = CasaccaRuoloReparto(entityColorA: teamEntity.colorA ?? "black", entityColorB: teamEntity.colorB ?? "blue")
    
    guard !(self.currentTeamEntity.giocatoriTesserati?.allObjects.isEmpty ?? true) else {return}
    
        getTeamPlayers()
        
    print("Nuovo teamData per entity: \(currentTeamEntity.nome ?? "") ")
        
    }

   var casaccaTeam: CasaccaRuoloReparto?
    
    private var budgetFromLega: Int
    private var distintaPortieri: Int
    private var distintaDifesa: Int
    private var distintaCentrocampo: Int
    private var distintaAttacco: Int
     
    var numeroPartecipanti: Int
     
    private var capienzaRosa: Int {distintaPortieri + distintaDifesa + distintaCentrocampo + distintaAttacco}
    private var giocatoriAncoraDaAcquistare: Int {capienzaRosa - playerEntityTesserati.count}
    
    func getTeamPlayers() {
     
        let request = NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
        
       // let sort = NSSortDescriptor(keyPath: \PlayerEntity.id, ascending: true)
      //  request.sortDescriptors = [sort]
        
        let filter = NSPredicate(format: "teamRiferimento == %@", self.currentTeamEntity)
        request.predicate = filter // filtra i business ritornando quelli che hanno come nome "Apple"
        
        do {
            
            playerEntityTesserati = try manager.context.fetch(request)
            print("PlayerEntityTesserati caricata")
       
            
        } catch let error {
            
            print("Error fetching. \(error.localizedDescription)")
        }
        
        
    }
    
    func save() {
        
        self.playerEntityTesserati.removeAll()
      //  self.playerModelTesserati.removeAll()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
          
            self.manager.save()
            self.getTeamPlayers()
        }
      
    }

    // Merging with teamModel
    
    var distinta:Dictionary<String,[PlayersModel]> {return Dictionary(grouping: playerModelTesserati){ $0.casaccaRuoloReparto.nomeDelReparto }}
    
    func checkReparto (player:PlayersModel) -> Bool {
        
        switch player.ruolo {
        
        case "P":
            return distinta["Portieri"]?.count == distintaPortieri
        case "D":
            return distinta["Difesa"]?.count == distintaDifesa
        case "C":
            return distinta["Centrocampo"]?.count == distintaCentrocampo
        case "A":
            return distinta["Attacco"]?.count == distintaAttacco
        default:
            return false
        }
        
        
    }
    
    var budgetCorrente:Int {
                
        var budgetSquadra = budgetFromLega
        
        for player in playerEntityTesserati {
            
            let costoIntero = Int(player.costoCartellino ?? "0")
            budgetSquadra -= costoIntero!
           }
        
        return budgetSquadra
    }
    
    func budgetProgression () -> HStack<TupleView<(Text,Text,Text)>> {
   
        let budget = budgetCorrente
        
        var budgetColor:Color
        
        if budget > 250 {budgetColor = Color.green}
        else if budget > 100 {budgetColor = Color.orange}
        else {budgetColor = Color.red}
        
        if giocatoriAncoraDaAcquistare != 0 {
            return HStack(alignment: .center, spacing: 0){ Text("\(budget - (giocatoriAncoraDaAcquistare - 1))").bold().foregroundColor(budgetColor).font(.system(size: 16))
                Text("+").font(.system(size: 14))
                Text("(\(giocatoriAncoraDaAcquistare - 1))").foregroundColor(Color.red).font(.system(size: 16))}
        }
        else {
        return HStack(alignment: .center, spacing: 0){
            Text("")
            Text("\(budget)").bold().foregroundColor(Color.green).font(.system(size: 18))
            Text("")
            }}
    
    }
    
    func repartoCount (player: PlayersModel) -> HStack<TupleView<(Text,Text)>> {
        // Questo metodo adatta la Text al reparto e ritorna il conto dei giocatori di ogni reparto.
        // Usata nella BidView
        
        let keyReparto = player.casaccaRuoloReparto.nomeDelReparto
        let count = self.distinta[keyReparto]?.count
        var reparto: Int
  
        switch player.ruolo {
        case "P":
        reparto = distintaPortieri
        case "D":
        reparto = distintaDifesa
        case "C":
        reparto = distintaCentrocampo
        case "A":
        reparto = distintaAttacco
        default:
        reparto = 0
        }
        
        return HStack{ Text("\(player.ruolo):").bold().font(.system(size: 15))
            Text("\(count ?? 0)/\(reparto)").font(.system(size: 15)).bold().foregroundColor(count ?? 0 < reparto ? Color.orange : Color.green)}
        
    }
    
    func checkRosa (ruoloGiocatore:String, bid:Int) -> Bool {
        // Questo metodo blocca le Bid a quelle squadre che hanno già il reparto completo e si accerta di essere dentro il budget
        // Usato nella Bid view in un Guard
        var countGiocatore = 0
        var limiteDistinta:Int
        var budgetSquadra = self.budgetFromLega
        
        switch ruoloGiocatore {
        case "P":
            limiteDistinta = distintaPortieri
        case "D":
            limiteDistinta = distintaDifesa
        case "C":
            limiteDistinta = distintaCentrocampo
        case "A":
            limiteDistinta = distintaAttacco
        default:
            limiteDistinta = 50
        }
        
        for player in playerModelTesserati {
            
            if player.ruolo == ruoloGiocatore {countGiocatore += 1}
            budgetSquadra -= player.costoCartellino
        }
        
        
        budgetSquadra -= ((giocatoriAncoraDaAcquistare - 1) + bid)
        
        if countGiocatore < limiteDistinta && budgetSquadra >= 0 {return true} else {return false}
    }
    
    func costoReparto (reparto:String) -> Int {
        var costo = 0
        
        for player in distinta[reparto]! {
            
            let prezzo = player.costoCartellino
            costo += prezzo
        }
        return costo
    }

    func addNewPlayerEntity(id: Int, costo: Int) {
        
        guard let elencoTesseratiLega = self.currentTeamEntity.legaRiferimento?.giocatoriTrasferiti?.allObjects as? [PlayerEntity] else {return}
       
        if !elencoTesseratiLega.map({$0.id}).contains(String(id)) {
            print("Entità giocatore non esistente")
            
            let newPlayer = PlayerEntity(context: manager.context)
            newPlayer.id = String(id)
            newPlayer.costoCartellino = String(costo)
            newPlayer.dataTrasferimento = Date()
            
            newPlayer.legaRiferimento = self.currentTeamEntity.legaRiferimento
            newPlayer.teamRiferimento = self.currentTeamEntity

            save()
            
            print("Lega: \(newPlayer.legaRiferimento?.nomeLega ?? "")")
            print("Squadra: \(newPlayer.teamRiferimento?.nome ?? "")")
        }
        else {
            print("Entità giocatore esistente")
            
            let entity = elencoTesseratiLega.first {$0.id == String(id)}
            
            entity?.costoCartellino = String(costo)
            entity?.teamRiferimento = self.currentTeamEntity
            entity?.dataTrasferimento = Date()
            save()
            
            print("Costo cartellino: \(entity?.costoCartellino ?? "0") ")
            print("Lega di Riferimento: \(entity?.legaRiferimento?.nomeLega ?? "")")
            print("Bidder: \(entity?.teamRiferimento?.nome ?? "")")
            }

    }
    
    func svincolaPlayerEntity(playerModel: PlayersModel) {
        
        if let currentPlayerEntity = playerEntityTesserati.first(where: {$0.id == String(playerModel.id)}) {
            
            currentPlayerEntity.costoCartellino = "0"
            self.currentTeamEntity.removeFromGiocatoriTesserati(currentPlayerEntity)
            
            save()
            print("playerEntity di \(playerModel.nome) svincolata con successo.")
        
        }else {print("Error: playerEntity non coincidente in teamData di: \(self.currentTeamEntity)")}

        
    }

}
