//
//  PlayersData.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 22/06/21.
//

import Foundation
import Combine
import CoreData


final class PlayersData: ObservableObject, Identifiable {
  
    @Published var lista21s22: [PlayersModel] = []
    
    let algoritmoData: AlgoritmoGuidaData = AlgoritmoGuidaData()
    let leagueEntityProprietaria: LeagueEntity
  
    var cancellables = Set<AnyCancellable>()
    var listaTrasferiti: [PlayersModel] = []
    
    init (legaProprietaria: LeagueEntity) {
        
        self.leagueEntityProprietaria = legaProprietaria
        getListaGiocatori()
        
    }
 
    var playerDictionary : Dictionary<String , [PlayersModel]> {return Dictionary(grouping: lista21s22) { $0.casaccaRuoloReparto.nomeDelReparto }}
    
    var listaOrdinataKey:[String] {playerDictionary.keys.sorted{$0 > $1};}
    
    func listaFiltrata (reparto:String, showFavoriteOnly:Bool, searchText:String, isPresented:Bool, startFrom: PlayersModel?, repartoAllActives: Bool) -> [PlayersModel] {
        
        guard isPresented else {return []}
        
        updateListaStagioneCorrente() // non è una ripetizione, ma ogni volta che torniamo alla lista viene aggiornata per eventuali trasferimenti o opzioni sul giocatore
        
        let listaFavoriteOr = self.playerDictionary[reparto]?.filter { player in
            !showFavoriteOnly || player.isFavorite
        }
       
        let filteredFavoriteList = listaFavoriteOr?.filter {searchText.isEmpty ? true : $0.nome.lowercased().contains(searchText.lowercased())}
        
        var ultimateList = filteredFavoriteList?.sorted{$0.nome < $1.nome}.filter { player in
            player.id != 240582
        } ?? []
      
        // Modifica per impostare il giocatore di partenza
        
        guard startFrom != nil && !repartoAllActives && startFrom?.casaccaRuoloReparto.nomeDelReparto == reparto else {return ultimateList}
        
        let lastIndex = ultimateList.count - 1
        var removed: PlayersModel
        
        repeat {
            
        removed = ultimateList.remove(at: lastIndex)
        ultimateList.insert(removed, at: 0)
            print("Ciclo Repeat While in corso")
            
        } while removed != startFrom
        
        
        return ultimateList
    }
    
    func getListaGiocatori() {
        
        guard let url = URL(string: "https://fantabid.it/statistiche/Stat_2021-22.json") else { return }
      //  url.removeAllCachedResourceValues()
        
        URLSession.shared.dataTaskPublisher(for: url)
           // .subscribe(on: DispatchQueue.global(qos: .background)) // questo non è necessario perchè di default il dataTAsk usa un altro thread
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PlayersModel].self, decoder: JSONDecoder())
           // .replaceError(with: []) // -> invece di gestire l'errore possiamo usare replaceError per rimpiazzare l'errore con qualcos'altro, in ques'esempio con un array vuoto. Se usiamo questo possiamo abolire il completion del sink (con tutto lo switch) e usare solo il receiveValue
            .sink { (completion) in
               // print("COMPLETION: \(completion)")
                switch completion {
                
                case .finished :
                print("PlayerModel dal json Downloaded")
                    DispatchQueue.global(qos: .background).async {
                        self.updateListaStagioneCorrente()
                        self.algoritmoData.updateStocks(playersModel: self.lista21s22)
                    }
                    // abbiamo deciso di metterlo qui perchè in questo modo lo eseguiamo sullo stesso Thread e quindi eseguiamo l'aggiornamento della lista solo dopo aver caricato tutti i giocatori.
                case .failure(let error):
                    print("There was an error: \(error)")
                }
                
            } receiveValue: {[weak self] (returnedPosts) in
            
                self?.lista21s22 = returnedPosts
            }
            .store(in: &cancellables)
        
        
    }
    
    func handleOutput (output: URLSession.DataTaskPublisher.Output) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            
            throw URLError(.badServerResponse)
        }
        
        return output.data
        
    }
   
    func updateListaStagioneCorrente() {
      
        let listaGiocatoriLega = leagueEntityProprietaria.giocatoriTrasferiti?.allObjects as? [PlayerEntity]
        
        for playerEntity in listaGiocatoriLega ?? [] {
            
            let id = playerEntity.id
            
            if var tesserato = lista21s22.first(where: {$0.id == Int(id ?? "0")}) {
                
                guard let tesseratoIndex = lista21s22.firstIndex(of: tesserato) else {return}
                lista21s22.remove(at: tesseratoIndex)
                
                tesserato.modificaCostoCartellino = Int(playerEntity.costoCartellino ?? "0")
                tesserato.modificaIsFavorite = playerEntity.isFavorite
                tesserato.modificaOwner = playerEntity.teamRiferimento?.nome
                tesserato.modificaDataTrasferimento = playerEntity.dataTrasferimento
     
                lista21s22.append(tesserato)
            }
            print("UpdateListaGiocatori -> Player Model Updated successfully")
        }
    }
    
}
