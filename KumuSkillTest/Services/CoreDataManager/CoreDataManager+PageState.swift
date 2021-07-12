//
//  CoreDataManager+PageState.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/12/21.
//

import CoreData

extension CoreDataManager {
    ///Get page visit data from Core Data
    func getPageSate(pageId: Int16) -> Result<PageState, AppError> {
        let fetchRequest = NSFetchRequest<PageState>(entityName: K.CoreDataEntity.pageState)
        fetchRequest.predicate = NSPredicate(format: "\(K.APIParameterKey.pageId) = %@", argumentArray: [pageId])

        do {
            let results = try self.container.viewContext.fetch(fetchRequest)
            if let pageVisit = results.first {
                if let viewModelData = pageVisit.value(forKey: K.APIParameterKey.viewModel) as? Data {
                    let viewModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(viewModelData) as? [[String : Any]]
                    pageVisit.viewModel = viewModel ?? []
                }
                return .success(pageVisit)
            } else {
                return .failure(AppError.notFound)
            }
        } catch let error as NSError {
            return .failure(AppError.failed(error))
        }
    }

    /// Save pageVisit data  to core data.
    ///
    /// - Parameters:
    ///   - page: the page visit data to be saved
    func savePageState(page: PageState) -> Result<Bool, AppError> {
        let managedContext = self.container.viewContext
        guard let entity =
                NSEntityDescription.entity(forEntityName: K.CoreDataEntity.pageState,
                                           in: managedContext) else { return .success(true) }
        
        let fetchRequest = NSFetchRequest<PageState>(entityName: K.CoreDataEntity.pageState)
        fetchRequest.predicate = NSPredicate(format: "\(K.APIParameterKey.pageId) = %@", argumentArray: [page.pageId])

        do {
            let results = try managedContext.fetch(fetchRequest)
            let viewModelObject = try? NSKeyedArchiver.archivedData(withRootObject: page.viewModel, requiringSecureCoding: false)
            
            if let item = results.first {
                item.setValue(page.lastVisitedDate, forKeyPath: K.APIParameterKey.lastVisitedDate)
                item.setValue(viewModelObject, forKey: K.APIParameterKey.viewModel)
            } else {
                let item = NSManagedObject(entity: entity, insertInto: managedContext)

                item.setValue(page.pageId, forKey: K.APIParameterKey.pageId)
                item.setValue(page.lastVisitedDate, forKeyPath: K.APIParameterKey.lastVisitedDate)
                item.setValue(viewModelObject, forKey: K.APIParameterKey.viewModel)
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        
        do {
            try managedContext.save()
            return .success(true)
        } catch let error as NSError {
            return .failure(AppError.failed(error))
        }
    }
}
