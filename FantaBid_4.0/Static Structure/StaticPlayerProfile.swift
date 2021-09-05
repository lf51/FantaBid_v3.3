//
//  StaticPlayerProfile.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 30/06/21.
//

import Foundation


struct StaticPlayerProfile: Identifiable, Hashable, Codable {
      
    //Valori assegnati tramite file json e funzione Load
    let id:Int
    
    let ruolo: String
    let nome: String
    let squadra: String
    
    let partiteGiocate: Int
    let mediaVoto: String
    let mediaFantaVoto: String
    
    let goalFatti: Int
    let goalSubiti: Int
    let autoGoal: Int
    
    let assist: Int
    let ammonizioni: Int
    let espulsioni: Int
    
    var rp: Int
    var rc: Int
    
    //
    // Computed necessarie
    
    var siglaSquadra:String {
        
        let array = Array(squadra)
        let sigla:[Character] = [array[0],array[1],array[2]]
       
        return String(sigla).uppercased()
    }
    
    // Sezione Algoritmo

    var NSStringMFV: NSString {
        
      let newValue = mediaFantaVoto.replacingOccurrences(of: ",", with: ".")
        
       return NSString(string: newValue)
        
        //in questa computed prima rimuoviamo la virgola e la sostituiamo con il punto, e poi trasformiamo la mediafantavoto in una NSString necessaria per l'ulteriore trasformazione in float. Con la virgola, il float mi ritorna l'arrotondamento all'intero con una sequenza poi di zeri
    }
    
    var totalScore: Float {Float(partiteGiocate) * NSStringMFV.floatValue}
    
}

//Questa struttura è una gemella del PlayerProfile depotenziata. Qui vengono caricate con la medesima funzione load le statistiche delle stagioni passate e non vi è interazione, nel senso che questa struttura a differenza della gemella non possiede variabili dinamiche. In questo modo evitiamo che da dentro un playerProfile si crei una spirale che attraverso la porta delle statistiche permette di entrare dentro un altro playerProfile all'infinito forse. Il file di supporto a questa struttura è una classe chiamata sempre StaticPlayersStat
