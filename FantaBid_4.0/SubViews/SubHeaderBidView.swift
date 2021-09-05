//
//  SwiftUIView.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 05/09/21.
//

import SwiftUI

struct SubHeaderBidView:View {
    
    var playerCorrente: PlayersModel
    @Binding var animationAmount: CGFloat
    
    var body: some View {
        
        HStack{
            
            VStack {
            Text("...")
 
                    Text("•")
                .padding(0)
                .background(Color.green)
                .foregroundColor(.green)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.green)
                        .scaleEffect(animationAmount)
                        .opacity(Double(2 - animationAmount))
                        .animation(
                            Animation.easeOut(duration: 0.9)
                                .repeatForever(autoreverses: false)
                        )
                )
               .onAppear {
                    self.animationAmount = 2
           }

               Text("•")
            .padding(0)
            .background(Color.red)
            .foregroundColor(.red)
            .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white))
                
            }.padding(.trailing)
       
            Group{
            
            VStack{
                
            Text("PG")
                Text("\(playerCorrente.partiteGiocate)")
                Text("\(playerCorrente.statistiche.stagione20s21.partiteGiocate)")
            }
            Spacer()
            
            VStack{
                
            Text("MV")
                Text("\(playerCorrente.mediaVoto)")
                Text("\(playerCorrente.statistiche.stagione20s21.mediaVoto)")
            }
            Spacer()
            
            VStack{
                
            Text("MFV")
            Text("\(playerCorrente.mediaFantaVoto)")
                Text("\(playerCorrente.statistiche.stagione20s21.mediaFantaVoto)")
            }
            Spacer()
            }
            Group{
            
            VStack{
                
                Text("").frame(width: 20, height: 20).background(Color.yellow).cornerRadius(5.0)
                Text("\(playerCorrente.ammonizioni)")
                Text("\(playerCorrente.statistiche.stagione20s21.ammonizioni)")
            }
            Spacer()
            
            VStack{
                
                Text("").frame(width: 20, height: 20).background(Color.red).cornerRadius(5.0)
                Text("\(playerCorrente.espulsioni)")
                Text("\(playerCorrente.statistiche.stagione20s21.espulsioni)")
            }
            
            Spacer()
            
            VStack{
                
                Text(playerCorrente.ruolo == "P" ? "GS" : "G+A").bold()
                if playerCorrente.ruolo != "P"{
                    Text("\(playerCorrente.goalFatti + playerCorrente.assist)")
                    Text("\(playerCorrente.statistiche.stagione20s21.goalFatti + playerCorrente.statistiche.stagione20s21.assist)")
                }else {
                    Text("\(playerCorrente.goalSubiti)")
                    Text("\(playerCorrente.statistiche.stagione20s21.goalSubiti)")
                }
                 
            }

            }
        }
        
    }
}

/*
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
*/
