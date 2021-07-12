//
//  PageState.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/12/21.
//

import Foundation
import CoreData

@objc(PageState)
public class PageState: NSManagedObject {
    @NSManaged var pageId: Int16
    @NSManaged var lastVisitedDate: String
    @NSManaged var viewModel: [[String : Any]]
    
    required convenience public init(pageId: Int16, lastVisitedDate: String, viewModel: [[String: Any]]) {
        let context = CoreDataManager.shared.container.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: K.CoreDataEntity.pageState, in: context) else { fatalError() }

        self.init(entity: entity, insertInto: context)
        
        self.pageId = pageId
        self.lastVisitedDate = lastVisitedDate
        self.viewModel = viewModel
    }
}
