//
//  PlayersStat.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 29/06/21.
//

import Foundation

class StaticPlayerStat {
    
    private static var stagione15s16:[StaticPlayerProfile] = load("Stat_2015-16.json")
    private static var stagione16s17:[StaticPlayerProfile] = load("Stat_2016-17.json")
    private static var stagione17s18:[StaticPlayerProfile] = load("Stat_2017-18.json")
    private static var stagione18s19:[StaticPlayerProfile] = load("Stat_2018-19.json")
    private static var stagione19s20:[StaticPlayerProfile] = load("Stat_2019-20.json")
    private static var stagione20s21:[StaticPlayerProfile] = load("Stat_2020-21.json")
    
    private var index15s16:Int?
    private var index16s17:Int?
    private var index17s18:Int?
    private var index18s19:Int?
    private var index19s20:Int?
    private var index20s21:Int?
    
    init(id:Int){
        
        self.index15s16 = StaticPlayerStat.stagione15s16.firstIndex(where: {$0.id == id}) ?? 0
        self.index16s17 = StaticPlayerStat.stagione16s17.firstIndex(where: {$0.id == id}) ?? 0
        self.index17s18 = StaticPlayerStat.stagione17s18.firstIndex(where: {$0.id == id}) ?? 0
        self.index18s19 = StaticPlayerStat.stagione18s19.firstIndex(where: {$0.id == id}) ?? 0
        self.index19s20 = StaticPlayerStat.stagione19s20.firstIndex(where: {$0.id == id}) ?? 0
        self.index20s21 = StaticPlayerStat.stagione20s21.firstIndex(where: {$0.id == id}) ?? 0
        
        // se ritorna nil, perchè quel giocatore non è presente nel database di quella stagione, va di default alla posizione zero, che è quella contenente il tester. Il tester è un giocatore fittizio con le stat tutte a zero.
    }
    
    var stagione15s16:StaticPlayerProfile {StaticPlayerStat.stagione15s16[index15s16!]}
    var stagione16s17:StaticPlayerProfile {StaticPlayerStat.stagione16s17[index16s17!]}
    var stagione17s18:StaticPlayerProfile {StaticPlayerStat.stagione17s18[index17s18!]}
    var stagione18s19:StaticPlayerProfile {StaticPlayerStat.stagione18s19[index18s19!]}
    var stagione19s20:StaticPlayerProfile {StaticPlayerStat.stagione19s20[index19s20!]}
    var stagione20s21:StaticPlayerProfile {StaticPlayerStat.stagione20s21[index20s21!]}
    
}

func load<T:Decodable>(_ filename:String) -> T {
    
    let data:Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {fatalError("Non è possibile trovare \(filename) in the main bundle") }
    
    do {
        data = try Data(contentsOf: file)
    } catch {fatalError("Non è possibile caricare il file \(filename)") }
    
    do { let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {fatalError("Impossibile eseguire il PARSE sul file \(filename) as \(T.self):\n\(error)") }
    
}
