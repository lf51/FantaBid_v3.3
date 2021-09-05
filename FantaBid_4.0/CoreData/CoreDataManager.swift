//
//  CoreDataManager.swift
//  FantaBid_4.0
//
//  Created by Calogero Friscia on 04/08/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        
        container = NSPersistentContainer(name: "FantabidCoreData")
        container.loadPersistentStores { (description, error) in
            
            if let error = error {
                
                print("Error loading data : \(error)")
            }
        }
        context = container.viewContext
        
    }
    
    func save() {
        
        do {
            try context.save()
            
            print("Saved successfully")
            
        } catch let error {
            
            print("Error saving core data: \(error.localizedDescription)")
        }
    }
    
}

