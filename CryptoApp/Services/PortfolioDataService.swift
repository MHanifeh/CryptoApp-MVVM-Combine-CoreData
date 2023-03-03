//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 12/8/1401 AP.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container : NSPersistentContainer
    private let containerName : String = "PortfolioContainer"
    private let entityname : String = "PortfolioEntity"
    
    @Published var savedEntities : [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { ( _ , error) in
            if let error = error {
                print("Error fetching data :\(error)------------------------------")
            }
            self.getPortfolio()
        }
     
    }
    
    // MARK : PUBLIC
    
     func uppdatePortfolio (coin : CoinModel , amount : Double){
         print("2 woooooooow")
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            if amount > 0 {
                uppdate(entity: entity, amount: amount)
            }else{
                delete(entity: entity)
            }
        }else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK : PRIVATE
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityname)
        do {
           savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio Entities :\(error)------------------------------")
        
        }
    }
    
    private func add(coin : CoinModel , amount : Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChange()
    }
    
    private func uppdate(entity : PortfolioEntity,amount : Double){
        entity.amount = amount
        applyChange()
    }
    private func delete(entity : PortfolioEntity){
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("error saving to core data :\(error)--------------------------------")
        }
    }
    private func applyChange(){
       save()
        getPortfolio()
    }
    
}
