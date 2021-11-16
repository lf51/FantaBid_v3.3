//
//  Casacca.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 30/06/21.
//

import Foundation
import SwiftUI

struct CasaccaRuoloReparto {
    
    var squadra:String
    var ruolo:String
    
   private var strisciaA:Color = Color.clear
   private var strisciaB:Color = Color.clear
    //le due strisce vanno messe Private una volta fatto l'upgrade a Gradiente in tutto il codice
    
    // Le proprietà per cui abbiamo creato questo Oggetto
    var coloriSocialiCasacca:LinearGradient { LinearGradient(gradient: Gradient(colors: [strisciaA, strisciaB]), startPoint: .leading, endPoint: .trailing)}
    var coloriSocialiRadiali: RadialGradient {RadialGradient(gradient: Gradient(colors: [strisciaA, strisciaB]), center: .bottomLeading, startRadius: 5, endRadius: 40) }
    
    var coloriDelRuolo:Color = Color.clear
    var nomeDelReparto:String = ""

    init(squadra:String,ruolo:String){
        
       self.squadra = squadra
       self.ruolo = ruolo
        
        coloriCasacca(squadra: squadra)
        coloreRuoloAndReparto(ruolo: ruolo)
    }
    
    init(entityColorA: String, entityColorB: String) {
        
        self.squadra = ""
        self.ruolo = ""
        fromStringToColor(stringColorA: entityColorA, stringColorB: entityColorB)
    }
    
   mutating func fromStringToColor(stringColorA: String, stringColorB: String) {
        
        switch stringColorA {
        
        case "black":
            strisciaA = .black
        case "white":
            strisciaA = .white
            
        default: strisciaA = Color.clear
        
        }
        switch stringColorB {
        case "black":
            strisciaB = .black
        case "blue":
            strisciaB = .blue
        case "gray":
            strisciaB = .gray
        case "green":
            strisciaB = .green
        case "orange":
            strisciaB = .orange
        case "pink":
            strisciaB = .pink
        case "purple":
            strisciaB = .purple
        case "red":
            strisciaB = .red
        case "white":
            strisciaB = .white
        case "yellow":
            strisciaB = .yellow
            
        default: strisciaB = Color.clear
        
        }
        
    }
    
    
    mutating func coloriCasacca(squadra:String) {
    
switch squadra {

case "Atalanta": strisciaA = Color.blue; strisciaB = Color.black
case "Inter": strisciaA = Color.black; strisciaB = Color.blue
case "Milan": strisciaA = Color.red; strisciaB = Color.black
case "Juventus": strisciaA = Color.white; strisciaB = Color.black
case "Napoli": strisciaA = Color.blue; strisciaB = Color.blue
case "Lazio": strisciaA = Color.white; strisciaB = Color.blue
case "Roma": strisciaA = Color.yellow; strisciaB = Color.red
case "Sassuolo": strisciaA = Color.black; strisciaB = Color.green
case "Sampdoria": strisciaA = Color.blue; strisciaB = Color.white
case "Verona": strisciaA = Color.blue; strisciaB = Color.yellow
case "Genoa": strisciaA = Color.blue; strisciaB = Color.red
case "Bologna": strisciaA = Color.blue; strisciaB = Color.red
case "Fiorentina": strisciaA = Color.purple; strisciaB = Color.purple
case "Udinese": strisciaA = Color.white; strisciaB = Color.black
case "Spezia": strisciaA = Color.white; strisciaB = Color.black
case "Cagliari": strisciaA = Color.blue; strisciaB = Color.red
case "Empoli":strisciaA = Color.white; strisciaB = Color.blue
case "Salernitana": strisciaA = Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)); strisciaB = Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
case "Venezia": strisciaA = Color.orange; strisciaB = Color(#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1))
case "Torino": strisciaA = Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)); strisciaB = Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))

default: strisciaA = Color.black; strisciaB = Color.black

}
    
}
    
    mutating func coloreRuoloAndReparto(ruolo:String) {
      
    switch ruolo {

    case "P": self.coloriDelRuolo = Color.yellow; self.nomeDelReparto = "Portieri"
    case "D": self.coloriDelRuolo = Color(#colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)); self.nomeDelReparto = "Difesa"
    case "C": self.coloriDelRuolo = Color.blue; self.nomeDelReparto = "Centrocampo"
    case "A": self.coloriDelRuolo = Color.green; self.nomeDelReparto = "Attacco"
    default: self.coloriDelRuolo = Color.black; self.nomeDelReparto = ""
}

}

}

enum Reparto: String, CaseIterable, Identifiable {
    case Portieri
    case Difesa
    case Centrocampo
    case Attacco
    
    case All
    case Opzionati
    
    var id: String { self.rawValue }
}
