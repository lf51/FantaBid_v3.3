//
//  ContentView.swift
//  FantaBid_4.3
//
//  Created by Calogero Friscia on 07/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var federationLeaguesData: FederationLeaguesData = FederationLeaguesData.instance
    @State var openHomeView: Bool = false

    var body: some View {
        
        if openHomeView {
            
            HomeView(federationLeaguesData: federationLeaguesData)
            
        } else {
            
            PulseHomeView(buttonAction: $openHomeView)
        }

}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
         
    }
}

// Nella versione 4.2 funziona Tutto! La salviamo per lavorare sulla NavigationView in questa nuova versione 4.3
