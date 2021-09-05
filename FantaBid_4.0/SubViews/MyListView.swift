//
//  ListView.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 12/08/21.
//

import SwiftUI

struct MyListView: View {

    var isComplete:Bool = false
    
    var testoB:String = ""
    var testoC:String = ""
    var imageName: String
   
    var body: some View {
        
        VStack {
                                HStack {
                            
                                    Image(systemName: "circlebadge.fill").foregroundColor(isComplete ? .green : .secondary)
                                    Text(testoB)
                                    Spacer()
                                    Image(systemName: imageName).foregroundColor(.secondary)
                                    Text(testoC).padding(.trailing)
                  
                                }
                                .foregroundColor(.primary)
                                .offset(x: 0, y: 0)
                                .frame(height:50)
                                .frame(maxWidth: .infinity)
                                .shadow(color:.primary,radius: 0.4)
                                .padding(.horizontal)
                                .offset(x: 0, y: 2)
                               
            Divider().padding(.horizontal)
    }
                
                }
            }
       

/*
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
*/
