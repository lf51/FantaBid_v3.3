//
//  PlayerProfile.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 22/06/21.
//

import Foundation
import SwiftUI
import Combine

struct PlayersModel: Identifiable, Hashable, Codable {
    
    //Valori assegnati tramite file json e funzione Load
    var id:Int
    
    var ruolo: String
    var nome: String
    var squadra: String
    
    var partiteGiocate: Int
    var mediaVoto: String
    var mediaFantaVoto: String
    
    var goalFatti: Int
    var goalSubiti: Int
    var autoGoal: Int
    
    var assist: Int
    var ammonizioni: Int
    var espulsioni: Int
    
    var rp: Int
    var rc: Int
   
    // Optional da usare in sola scrittura
    
    var modificaCostoCartellino:Int?
    var modificaOwner: String?
    var modificaIsFavorite: Bool?
    
    var modificaDataTrasferimento: Date?
    
    // computed da Optional da usare in sola lettura
    
    var costoCartellino: Int {modificaCostoCartellino ?? 0}
    var owner: String {modificaOwner ?? ""}
    var isFavorite: Bool {modificaIsFavorite ?? false}
    var svincolato: Bool {costoCartellino == 0}
    var dataTrasferimento: Date {modificaDataTrasferimento ?? Date()}
    //
    
    //Computed
    
    var siglaSquadra: String {
        
        let array = Array(squadra)
        let sigla:[Character] = [array[0],array[1],array[2]]
       
        return String(sigla).uppercased()
    }
    
    var statistiche: StaticPlayerStat {StaticPlayerStat(id: self.id)}

    var casaccaRuoloReparto: CasaccaRuoloReparto {CasaccaRuoloReparto(squadra: self.squadra, ruolo: self.ruolo)}
  
    // Sezione Algoritmo guida
  
    var payedPlayerPPP: Float {Float(costoCartellino) / statistiche.stagione20s21.totalScore} // il PPP pagato per lo score passato
    var seasonalScore: Float {Float(partiteGiocate) * NSStringMFV.floatValue} // lo score della stagione
    var seasonalPlayerPPP: Float {Float(costoCartellino) / seasonalScore} // il PPP della stagione corrente
    
    // Utili per il caroselloInfo
    
    var NSStringMFV: NSString {
        
      let newValue = mediaFantaVoto.replacingOccurrences(of: ",", with: ".")
        
       return NSString(string: newValue)

    }
    
    var NSStringMV: NSString {
        
      let newValue = mediaVoto.replacingOccurrences(of: ",", with: ".")
        
       return NSString(string: newValue)

    }
    
}
