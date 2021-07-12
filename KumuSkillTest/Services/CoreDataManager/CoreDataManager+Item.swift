//
//  CoreDataManager+Item.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/12/21.
//

import CoreData

extension CoreDataManager {
    ///Get items from Core Data
    func getItems() -> Result<[Item], AppError> {
        let fetchRequest =
            NSFetchRequest<Item>(entityName: K.CoreDataEntity.item)
        
        do {
            return .success(try self.container.viewContext.fetch(fetchRequest))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return .failure(AppError.failed(error))
        }
    }
    
    /// Save item to core data.
    ///
    /// - Parameters:
    ///   - storeItem: the item to be saved
    func saveItem(storeItem: Item) -> Result<Bool, AppError> {
        let managedContext = self.container.viewContext
        guard let entity =
                NSEntityDescription.entity(forEntityName: K.CoreDataEntity.item,
                                           in: managedContext) else { return .success(true) }
        
        let item = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        item.setValue(storeItem.trackId, forKey: K.APIParameterKey.trackId)
        item.setValue(storeItem.trackName, forKeyPath: K.APIParameterKey.trackName)
        item.setValue(storeItem.artworkStringUrl, forKey: K.APIParameterKey.artworkStringUrl)
        item.setValue(storeItem.currency, forKey: K.APIParameterKey.currency)
        item.setValue(storeItem.trackPrice, forKey: K.APIParameterKey.trackPrice)
        item.setValue(storeItem.genre, forKey: K.APIParameterKey.genre)
        item.setValue(storeItem.longDescription, forKey: K.APIParameterKey.longDescription)
        item.setValue(false, forKey: K.APIParameterKey.isFavorite)
        
        do {
            try managedContext.save()
            return .success(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return .failure(AppError.failed(error))
        }
    }
}
