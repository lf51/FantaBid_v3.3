//
//  HeaderNewInfo.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 29/08/21.
//

import SwiftUI

struct HeaderNewInfo: View {
    
    var playerCorrente: PlayersModel
    
    var payedPlayerPPPverified: Float {
        
        if self.playerCorrente.payedPlayerPPP == 0.0 || self.playerCorrente.payedPlayerPPP.isNaN || self.playerCorrente.payedPlayerPPP.isInfinite {
            
            return 0.0
            
        } else {
            
            return self.playerCorrente.payedPlayerPPP
        }
        
    }
    
    var body: some View {
        
        VStack(alignment:.leading) {
            
            HStack{
                Text("\(playerCorrente.ruolo)")
                    .frame(width: 25, height: 25)
                    .background(playerCorrente.casaccaRuoloReparto.coloriDelRuolo)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                Text("\(playerCorrente.nome)")
                    .bold()
                
                Image(systemName: playerCorrente.isFavorite ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
               
                    HStack {
                        Text("\(playerCorrente.costoCartellino)").bold().multilineTextAlignment(.trailing)
                        Image(systemName: "dollarsign.circle").padding(.leading,-5)
                    }
 
                Spacer()
                Text("\(playerCorrente.squadra)")
                
            }
            
            Divider().foregroundColor(.secondary)
            
            Text("Data ultimo trasfer: \(playerCorrente.dataTrasferimento) -- pPp: \(payedPlayerPPPverified)")
                .font(.system(size: 10.0))
                .italic()
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
   
        }
    }
}
/*
struct LocalHeader_Previews: PreviewProvider {
    static var previews: some View {
        LocalHeader()
    }
}

*/
