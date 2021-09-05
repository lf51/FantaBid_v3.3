//
//  HeaderSectionSetupLega.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 08/07/21.
//

import SwiftUI

struct HeaderSectionSheetReverse: View {
    
    @Binding var reverseSheet: Bool
    
    var body: some View {
        
        HStack {
            
            Text("Setup Lega")
            Spacer()
            
            Button(action: {reverseSheet.toggle()}, label: {
                Text("Cancel").shadow(radius: 15)
            })
            
        }.padding(.vertical,10).padding(.horizontal,2)

    }
}
struct HeaderSectionSetupLega_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSectionSheetReverse(reverseSheet: .constant(false))
    }
}
