//
//  LeagueData.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 22/06/21.
//

import Foundation
//import Combine
import CoreData

// La FederationLeaguesData rimpiazza il vecchio LeaguesData, diventa il livello più alto, quello che contiene tutte le leghe esistenti e permette la creazione di nuove


final class FederationLeaguesData: ObservableObject, Identifiable {
   
    let manager = CoreDataManager.instance
    static let instance = FederationLeaguesData()
    
    @Published var elencoLeghe: [LeagueEntity] = []
    
    init() {
        
        getLeagues()

    }
    
    func getLeagues() {
        
        let request = NSFetchRequest<LeagueEntity>(entityName: "LeagueEntity")
        
        let sort = NSSortDescriptor(keyPath: \LeagueEntity.nomeLega, ascending: true)
        request.sortDescriptors = [sort]
        
      // let filter = NSPredicate(format: "name == %@", "Apple")
      //  request.predicate = filter // filtra i business ritornando quelli che hanno come nome "Apple"
        
        do {
            
            elencoLeghe = try manager.context.fetch(request)
            print("leghe caricate")
            
        } catch let error {
            
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    @Published var creaLega:Bool = false
    @Published var usaValoriDefault:Bool = false
    @Published var isNuovoDefaultIn: Bool = false
    
    @Published var nomeLega:String = ""
    @Published var budget:String = ""
    @Published var numeroPartecipanti:String = ""
    
    @Published var distintaPortieri:String = ""
    @Published var distintaDifesa:String = ""
    @Published var distintaCentrocampo:String = ""
    @Published var distintaAttacco:String = ""
    
    var foundLeagueNameDuplicate: Bool {checkDuplicate()}
    
    var isNomeLegaOk:Bool {self.nomeLega != "" && self.nomeLega.count >= 3 && !foundLeagueNameDuplicate;}
    
    var isBudgetOk:Bool {Int(self.budget) != nil && Int(self.budget) ?? 0 > 0}
    var isPartecipantiOk:Bool {Int(self.numeroPartecipanti) != nil && Int(self.numeroPartecipanti) ?? 0 >= 1 && Int(self.numeroPartecipanti) ?? 0 <= 12}
    
    var isPortieriOk:Bool {Int(self.distintaPortieri) != nil && Int(self.distintaPortieri) ?? 0 >= 1 && Int(self.distintaPortieri) ?? 0 <= 5}
    var isDifesaOk:Bool {Int(self.distintaDifesa) != nil && Int(self.distintaDifesa) ?? 0 >= 6 && Int(self.distintaDifesa) ?? 0 <= 12}
    var isCentrocampoOk:Bool {Int(self.distintaCentrocampo) != nil && Int(self.distintaCentrocampo) ?? 0 >= 6 && Int(self.distintaCentrocampo) ?? 0 <= 12}
    var isAttaccoOk:Bool {Int(self.distintaAttacco) != nil && Int(self.distintaAttacco) ?? 0 >= 4 && Int(self.distintaAttacco) ?? 0 <= 10 }
    
    var isAllDataOk:Bool {isBudgetOk && isPartecipantiOk && isPortieriOk && isDifesaOk && isCentrocampoOk && isAttaccoOk;}
    
    func clean(all:Bool) {
        
        if all {
        self.nomeLega = ""
        self.budget = ""
        self.numeroPartecipanti = ""
        
        self.distintaPortieri = ""
        self.distintaDifesa = ""
        self.distintaCentrocampo = ""
        self.distintaAttacco = ""
        
        } else {self.nomeLega = ""}
    }
    
    func checkDuplicate () -> Bool {
   
        let listaNomiLeghe: [String] = elencoLeghe.map {$0.nomeLega ?? ""}
   
        return listaNomiLeghe.contains(self.nomeLega)
     
        
    }
    
    func addNewLeague() {
        
        let newLeague = LeagueEntity(context: manager.context)
        newLeague.id = String(elencoLeghe.count)
        
        if !self.usaValoriDefault {

            newLeague.nomeLega = self.nomeLega
            newLeague.budget = self.budget
            newLeague.numeroPartecipanti = self.numeroPartecipanti
            
            newLeague.distintaPortieri = self.distintaPortieri
            newLeague.distintaDifesa = self.distintaDifesa
            newLeague.distintaCentrocampo = self.distintaCentrocampo
            newLeague.distintaAttacco = self.distintaAttacco
  
        } else {
            
            newLeague.nomeLega = self.nomeLega
            
            newLeague.numeroPartecipanti = Default.partecipanti
            newLeague.budget = Default.budget
            
            newLeague.distintaPortieri = Default.portiere
            newLeague.distintaDifesa = Default.difesa
            newLeague.distintaCentrocampo = Default.centrocampo
            newLeague.distintaAttacco = Default.attacco
            
            // i valori di default possono essere consolidati tutti in forma di stringa direttamente
        }
  
        save()
    }

   func save() {
        
           elencoLeghe.removeAll()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
          
            self.manager.save()
            self.getLeagues()

        }
    
    }
    
    func deleteLeague(leagueEntity: LeagueEntity) {
        
        let league = leagueEntity
        manager.context.delete(league)
        save()
        
        print("LeagueEntity - \(league.nomeLega ?? "") - successfully deleted ")
    
    }
    
}

struct Default {
   
   static var portiere = "3"
   static var difesa = "8"
   static var centrocampo = "8"
   static var attacco = "6"
   
   static var budget = "350"
   static var partecipanti = "10"
   
   static func nuoviData (budget:String, partecipanti:String, portiere: String, difesa: String, centrocampo: String, attacco: String) {
       
    if let _ = Int(budget) {
        
        Self.budget = budget
    }
    
    if let _ = Int(partecipanti) {
        
        Self.partecipanti = partecipanti
    }
    
    if let _ = Int(portiere) {
        
        Self.portiere = portiere
    }
      
    if let _ = Int(difesa) {
        
        Self.difesa = difesa
    }
       
    if let _ = Int(centrocampo) {
        
        Self.centrocampo = centrocampo
    }
     
    if let _ = Int(attacco) {
     
        Self.attacco = attacco
    }
       
       
   }
   
}
