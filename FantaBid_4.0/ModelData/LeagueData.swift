//
//  CustomTeamData.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 28/06/21.
//

import Foundation
import CoreData
import SwiftUI

// Il nuovo LeagueData, messo al singolare per distinguerlo, non è più il vecchio contenitore di leghe, ma è la Lega, ossia un contenitore di squadre, e permette dunque di inserirne di nuove. Viene ad avere parte delle funzioni precedentemente possedute dal TeamsData

final class LeagueData: ObservableObject, Identifiable {
    
    let manager = CoreDataManager.instance
    
    let currentLeagueEntity: LeagueEntity
    let currentPlayersData: PlayersData
    
    @Published var starterPlayer: PlayersModel? = nil // serve pr impostare il player di partenza nell'Asta
    @Published var elencoTeamsEntity: [TeamEntity] = []
    
    var elencoTeamsData: [TeamData] {
        
        var elenco: [TeamData] = []
        
        for teamEntity in elencoTeamsEntity {
            
       let newTeamData = TeamData(teamEntity: teamEntity, playersData: currentPlayersData)
            
            elenco.append(newTeamData)
            
        }
        
        return elenco
    }

    init(legaRiferimento: LeagueEntity){
        
         self.currentLeagueEntity = legaRiferimento
         self.currentPlayersData = PlayersData(legaProprietaria: self.currentLeagueEntity)
        
        
         budgetFromLega = Int(self.currentLeagueEntity.budget ?? "0") ?? 0
         distintaPortieri = Int(self.currentLeagueEntity.distintaPortieri ?? "0") ?? 0
         distintaDifesa = Int(self.currentLeagueEntity.distintaDifesa ?? "0") ?? 0
         distintaCentrocampo = Int(self.currentLeagueEntity.distintaCentrocampo ?? "0") ?? 0
         distintaAttacco = Int(self.currentLeagueEntity.distintaAttacco ?? "0") ?? 0
         numeroPartecipanti = Int(self.currentLeagueEntity.numeroPartecipanti ?? "0") ?? 0

        print("DistintaPortieri: \(distintaPortieri)")
        
        guard !(self.currentLeagueEntity.partecipantiLega?.allObjects.isEmpty ?? true) else{
            print("LeagueData con legaRiferimento Vuoto. Nessuna squadra caricabile")
            return}

        getTeamsCurrentLeague()

         print("Nuovo leagueData con legaRiferimento. Elenco Squadre caricato")

    }

   var casaccaTeam: CasaccaRuoloReparto?
    
   private var budgetFromLega: Int
   private var distintaPortieri: Int
   private var distintaDifesa: Int
   private var distintaCentrocampo: Int
   private var distintaAttacco: Int
    
   var numeroPartecipanti: Int
    
   var capienzaRosa: Int {distintaPortieri + distintaDifesa + distintaCentrocampo + distintaAttacco}
   var totaleGiocatoriDaTrasferireInLega: Int {capienzaRosa * numeroPartecipanti;}

    func getTeamsCurrentLeague () {
        
        let request = NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
        
        let filter = NSPredicate(format: "legaRiferimento == %@", self.currentLeagueEntity)
        request.predicate = filter
        
        do {
            elencoTeamsEntity = try manager.context.fetch(request)
            print("squadre della Lega caricate")
          
        } catch let error {
            
            print("Error fetching. \(error.localizedDescription)")
        }

        
    }

  
   // @Published var teams:[TeamsModel] = []
    
   // @Published var teamIdSetting:Int = 1000
    
   // @Published var listaSquadreConfermata:Bool = false //necessario per creare la listaSquadre
   // @Published var openEditView: Bool = false // necessario per editare squadre già create
    
    @Published var emptyField:Bool = false
    
    @Published var customTeamName: String = ""
    @Published var customTeamFantaManager: String = ""
    
    @Published var customTeamNameUpdate: String = "" // -> Usiamo questo per l'update del nome, per evitare che nel campo di testo usato per il primo inserimento appaia l'editing del nuovo nome
    @Published var customTeamFantaManagerUpdate: String = ""
    
  //  @Published var currentTeam: TeamEntity? = nil

    var foundTeamNameDuplicate:Bool {checkDuplicate(nameTrueManagerFalse: true)}
    var foundTeamManagerDuplicate:Bool {checkDuplicate(nameTrueManagerFalse: false)}

    var isCustomNameOk: Bool {self.customTeamName != "" && self.customTeamName.count >= 3 && !foundTeamNameDuplicate}
    var isCustomManagerOk: Bool {self.customTeamFantaManager != "" && self.customTeamFantaManager.count >= 3 && !foundTeamManagerDuplicate}
    
    
    func updateTeamData (teamEntity: TeamEntity, trueXnomeFalseXmanager: Bool) {
        
        print(trueXnomeFalseXmanager ? "Start update NomeSquadra" : "Start Update Nome Manager")
        
        if trueXnomeFalseXmanager {
            
            let oldName = teamEntity.nome ?? ""
            
            guard self.customTeamNameUpdate != "" && self.customTeamNameUpdate.count >= 3 else {
                print("customTeamNameUpdate non corretto")
                return}
            
            let elencoTeam:[String] = elencoTeamsEntity.map {$0.nome ?? ""}
            
            guard !elencoTeam.contains(self.customTeamNameUpdate) else {return}
            
            teamEntity.nome = self.customTeamNameUpdate
            save()
            
            print("Nome Squadra aggiornato. Da \(oldName) a \(self.customTeamNameUpdate)")
            self.customTeamNameUpdate = ""
        
        } else {
            
            let oldName = teamEntity.fantaManager ?? ""
            
            guard self.customTeamFantaManagerUpdate != "" && self.customTeamFantaManagerUpdate.count >= 3 else {
                print("customTeamFantaManager non corretto")
                return}
            
            let elencoManager:[String] = elencoTeamsEntity.map {$0.fantaManager ?? ""}
            guard !elencoManager.contains(self.customTeamFantaManagerUpdate) else {return}
            
            teamEntity.fantaManager = self.customTeamFantaManagerUpdate
            save()
            
            print("Nome Manager aggiornato. Da \(oldName) a \(self.customTeamFantaManagerUpdate)")
            self.customTeamFantaManagerUpdate = ""
        }
        
    }
    
    func checkData() -> Bool {
        
        guard isCustomNameOk && isCustomManagerOk else {
            self.emptyField = true
            return false }
        
        self.emptyField = false
        return true
        
    }
    
    func checkDuplicate (nameTrueManagerFalse:Bool) -> Bool {
        
        if nameTrueManagerFalse {
        
            var listaNomiSquadre: [String] = []
            
            for team in self.elencoTeamsEntity {
               
                if let teamName = team.nome {
                listaNomiSquadre.append(teamName)
                }
            }
            
            return listaNomiSquadre.contains(self.customTeamName)
            
        }
        
        else {
            
            var listaNomiManager: [String] = []
            
            for team in self.elencoTeamsEntity {
 
                if let teamManager = team.fantaManager {
                    listaNomiManager.append(teamManager) }
            }
            
            return listaNomiManager.contains(self.customTeamFantaManager)
        }
        
    }
   
    func confermaLista() {
   
        for temporaryTeam in temporaryTeamList {
            
            newAssignStringColor()  // passiamo questo metodo per compilare la colorkey e il colorB da assegnare alla squadra
            
            let newTeamEntity = TeamEntity(context: manager.context)

            newTeamEntity.id = temporaryTeam.id
            newTeamEntity.nome = temporaryTeam.nome
            newTeamEntity.fantaManager = temporaryTeam.fantaManager
        
            newTeamEntity.colorA = self.colorKey
            newTeamEntity.colorB = self.colorB
            
            newTeamEntity.legaRiferimento = self.currentLeagueEntity
            
        }
        
        self.currentLeagueEntity.isListaConfermata = true
        save()

        print("Lista Squadre Temporanee, ora Entità, Confermata")
        
    }
    
    func save() {
        
        self.elencoTeamsEntity.removeAll()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
          
            self.manager.save()
            self.getTeamsCurrentLeague()
        }
    }
        
    func clean() {
        
        self.customTeamName = ""
        self.customTeamFantaManager = ""
        
    }
  
    var usedColor: [String:[String]] = [:]
    
    var colorKey: String = ""
    var colorB: String = ""
 
    func newAssignStringColor() {
        
        compileUsedColorDictionary()
        
        let comboColorAvaible: [String: [String]] = ["white": ["black", "blue", "gray", "green", "orange", "pink", "purple", "red","yellow"], "black": ["blue", "gray", "green", "orange", "pink", "purple", "red", "white" ,"yellow"]]
        
        let keys:[String] = ["white","black"]
        
        let shuffledKey = keys.shuffled() // viene shuffled l'array di chiavi e viene presa quella in posizione zero
        var currentKey = shuffledKey[0]
            
        if self.usedColor[currentKey]?.count == comboColorAvaible[currentKey]?.count {
            
            currentKey = shuffledKey[1]
        }
        
        let colorAvaible = comboColorAvaible[currentKey]?.filter({!(self.usedColor[currentKey]?.contains($0) ?? false) })
        
        self.colorB = (colorAvaible?.shuffled()[0])!
        self.colorKey = currentKey
      
    }
    
    func compileUsedColorDictionary(){
        
        var usedColorDictionary: [String:[String]] = ["white":[], "black": []]
        
        if let entityList = currentLeagueEntity.partecipantiLega?.allObjects as? [TeamEntity] {
            
            for entity in entityList {
                
                usedColorDictionary[entity.colorA!]?.append(entity.colorB!)
                
            }
        }
    
        self.usedColor = usedColorDictionary
        
    }

    
    func resetAllPin (teamEntity: TeamEntity) {
        
        let check:Bool = teamEntity.isPinned
            
            for team in elencoTeamsEntity {
                
                team.isPinned = false
                
            }
        
        if !check {
            
            teamEntity.isPinned = true
            save()
            
            print("All Pinned Reset. New Pin for \(teamEntity.nome ?? "")")
            
        } else {
            
            save()
            print("Squadre DePinnate")
        }

    }
    
    
    @Published var temporaryTeamList: [TemporaryTeamModel] = []
    
    var checkTemporaryCount: Bool {temporaryTeamList.count == numeroPartecipanti;}
    var checkEntityCount: Bool {currentLeagueEntity.partecipantiLega?.count ?? 0 == numeroPartecipanti;}
        
    func addNewTemporaryTeam() {
        
        guard checkData() else {return}
        
        let newTemporaryTeam = TemporaryTeamModel(id: String(temporaryTeamList.count), nome: self.customTeamName, fantaManager: self.customTeamFantaManager)
        
        temporaryTeamList.append(newTemporaryTeam)
        clean()
        
    }
    
    func removeTemporaryTeam (index: IndexSet) {
        
        temporaryTeamList.remove(atOffsets: index)
        
    }
    
    func addNewPlayerEntityFromHeaderInfoBid(id: Int, isFavorite: Bool) {
        
        guard let elencoTesseratiLega = self.currentLeagueEntity.giocatoriTrasferiti?.allObjects as? [PlayerEntity] else {return}
       
        if !elencoTesseratiLega.map({$0.id}).contains(String(id)) {
            print("Entità giocatore non esistente")
            
            let newPlayer = PlayerEntity(context: manager.context)
            newPlayer.id = String(id)
            newPlayer.isFavorite = !isFavorite
            newPlayer.legaRiferimento = self.currentLeagueEntity
            
            saveNewPlayerEntity()
            print(newPlayer.isFavorite.description)
        }
        else {
            print("Entità giocatore esistente")
            
            let entity = elencoTesseratiLega.first {$0.id == String(id)}
            
            entity?.isFavorite = !isFavorite
            saveNewPlayerEntity()
            
            print(entity?.isFavorite.description ?? false)
            }

    }
    
    func saveNewPlayerEntity() {
            
      // Questo save salva le nuove entita' di player creati senza una squadra, creati perchè opzionati/favoriti

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
              
                self.manager.save()
            
            }
    }

}
