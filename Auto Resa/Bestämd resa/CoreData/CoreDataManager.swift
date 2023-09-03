//
//  CoreDataManager.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-19.
//

import Foundation
import CoreData


class CoreDataManager: ObservableObject {
    
    var FelSparandeStationer = false
    var FelHitandeStationer = false
    
    
    let presistantContainer: NSPersistentContainer
    @Published var savedStationer: [StationDuo] = []
    
    init() {
        presistantContainer = NSPersistentContainer(name: "Stationer")
        presistantContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print("error loading core date: \(error)")
            } else {
                print("core data is primed and redy")
                
            }
        }
        fetchStationer()
        
    }
    
    
    
    func fetchStationer() {
        let request = NSFetchRequest<StationDuo>(entityName: "StationDuo")
        
        do {
            savedStationer = try presistantContainer.viewContext.fetch(request)
        } catch {
            print("error fetching stationer")
            self.FelHitandeStationer = true
        }
    }
    
    
    func addStationer(AvgångSta: String, AvgångStaID: String, DestinationSta: String, DestinationStaID: String){
        let New = StationDuo(context: presistantContainer.viewContext)
        New.avgang = AvgångSta
        New.avgangid = AvgångStaID
        New.destination = DestinationSta
        New.destinationid = DestinationStaID
        
        do {
            try presistantContainer.viewContext.save()
            fetchStationer()
            print("Lyckades Spara")
        } catch {
            print("error saving new stations")
            self.FelSparandeStationer = true
        }
        
    }
    
    
    func deleteStationer(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedStationer[index]
        presistantContainer.viewContext.delete(entity)
        
        do {
            try presistantContainer.viewContext.save()
            fetchStationer()
        } catch {
            print("error saving new stations")
            self.FelSparandeStationer = true
        }
        
    }
    
    
    
    
    func saveStationer() {
        do {
            try presistantContainer.viewContext.save()
            fetchStationer()
        } catch {
            print("error saving new stations")
            self.FelSparandeStationer = true
        }
    }
    
    
    
    
}
