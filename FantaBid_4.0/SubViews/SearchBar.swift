//
//  SerarchBar.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 06/07/21.
//
// copied from //axelhodler.medium.com/creating-a-search-bar-for-swiftui-e216fe8c8c7f
import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            
        }
        
        func searchBarCancelButtonClicked (_ searchBar: UISearchBar) { //Modifica 01/09
            
            if text.isEmpty {
                searchBar.resignFirstResponder()
                
            } else {text = ""}
            
        }
        
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text) //Modifica 01/09
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
       // searchBar.autocapitalizationType = .none
        searchBar.showsCancelButton = true
        context.coordinator.searchBarCancelButtonClicked(searchBar)
        
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        
            uiView.text = text
      
        if uiView.text == "" {uiView.resignFirstResponder()}

    }
}
