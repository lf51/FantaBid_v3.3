//
//  AlgoritmoGuidaAsta.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 25/08/21.
//

import Foundation

class AlgoritmoGuidaData: ObservableObject {
    
    @Published var pGpStock: [Float] = []
    @Published var pDpStock: [Float] = []
    @Published var pCpStock: [Float] = []
    @Published var pApStock: [Float] = []
    
    
    var pGp: Float {calcolaMedia(stock: pGpStock, oldStock: pppPortiere)}
    var pDp: Float {calcolaMedia(stock: pDpStock, oldStock: pppDifesa)}
    var pCp: Float {calcolaMedia(stock: pCpStock, oldStock: pppCentrocampo)}
    var pAp: Float {calcolaMedia(stock: pApStock, oldStock: pppAttacco)}

    
    func updateStocks(playersModel: [PlayersModel]) {
        
        for player in playersModel {
            
            if player.payedPlayerPPP == 0.0 {continue}
            if player.payedPlayerPPP.isNaN {continue}
            if player.payedPlayerPPP.isInfinite {continue}
            
           switch player.ruolo {
                
           case "P": self.pGpStock.append(player.payedPlayerPPP)
           case "D": self.pDpStock.append(player.payedPlayerPPP)
           case "C": self.pCpStock.append(player.payedPlayerPPP)
           case "A": self.pApStock.append(player.payedPlayerPPP)
            
           default:
            return
                
            }
            
            
        }
        print("PlayersData -> Stocks Update")
        
    }
    
    func calcolaMedia(stock: [Float], oldStock: PricePerPoint) -> Float {
        
        guard stock[0] == oldStock.pPpMedio else {
            print("Stock[0] and oldStockPpPMedio non coincidono")
            return 0.0}
        
        var currentStock = stock // creiamo uno stock gemello di quello passato per rielaborarlo qui
        currentStock.remove(at: 0) // rimuoviamo il valore in posizione zero, che è il pPpMedio del passato
        currentStock.insert(oldStock.pPpSomma, at: 0) // inseriamo la somma dei pPp del passato
        
        var total: Float = 0.0
        let element: Float = Float(stock.count - 1) + oldStock.unit // sottraiamo uno e aggiungiamo il numero di elementi con cui è creata la somma inserita in posizione Zero. Così ponderiamo il valore. Il valore in posizione zero varraà tanto quanti sono gli elementi che l'hanno generato. Mentre i nuovi valori valgono ciascuno UNO.
         
        for n in currentStock {
            
           total += n
            
        }

        print("total \(total) - element.count \(element)")
        return total / element
        
    }
    
    func choosePpp (playerRuolo: String) -> Float {
        
        switch playerRuolo {
        case "P": return pGp
        case "D": return pDp
        case "C": return pCp
        case "A": return pAp
        
        default:
           return 0.0
        }
        
        
    }
    
    func updatePPPValue (playerCorrente:PlayersModel, lastBid: Int) {
        
        
        let currentPPP:Float = Float(lastBid) / playerCorrente.statistiche.stagione20s21.totalScore
        
        if currentPPP != 0 && currentPPP != Float.nan && currentPPP != Float.infinity {
            
            switch playerCorrente.ruolo {
            
            case "P": self.pGpStock.append(currentPPP)
            case "D": self.pDpStock.append(currentPPP)
            case "C": self.pCpStock.append(currentPPP)
            case "A": self.pApStock.append(currentPPP)
                
                
            default:
                return
            }
            print("currentPPP -> \(currentPPP)")
            
        } else {print("currentPPP is not valid -> \(currentPPP)")} 
        
       
        
    }

    init() {
        
        self.pGpStock.append(pppPortiere.pPpMedio)
        self.pDpStock.append(pppDifesa.pPpMedio)
        self.pCpStock.append(pppCentrocampo.pPpMedio)
        self.pApStock.append(pppAttacco.pPpMedio)
    }
    
    //Dati vecchi estrapolati da Asta Murphys2 2020. Rappresentano l'aggregato di partenza per l'algoritmo
    let pppPortiere: PricePerPoint = PricePerPoint(unit: 25.0, pPpSomma: 2.498289318)
    let pppDifesa: PricePerPoint = PricePerPoint(unit: 69.0, pPpSomma: 2.323446556)
    let pppCentrocampo: PricePerPoint = PricePerPoint(unit: 67.0, pPpSomma: 3.760366892)
    let pppAttacco: PricePerPoint = PricePerPoint(unit: 51.0, pPpSomma: 7.552997805)
   // end
    
}


struct PricePerPoint {
    
    
    let unit: Float
    let pPpSomma: Float
    
    var pPpMedio: Float {pPpSomma / unit}
    
    
    
    /* 26/08/2021
     
     Dati estrapolati da Asta fantaMurphys 2 del settembre 2020
     
     budget -> 350
     rosa -> 25
     
     Portieri(3):
     
     unità -> 25
     somma pGp -> 2.498289318
     pGp medio (pGp/unità) -> 0.099931573
     
     Difesa(8):
     
     unità -> 69
     somma pDp -> 2.323446556
     pDp medio (pDp/unità) -> 0.033673138
     
     Centrocampo(8):
     
     unità -> 67
     somma pCp -> 3.760366892
     pCp medio (pCp/unità) -> 0.056124879
     
     Attacco(6):
     
     unità -> 51
     somma pAp -> 7.552997805
     pAp medio (pAp/unità) -> 0.148097996
     
     */
    
    
}
