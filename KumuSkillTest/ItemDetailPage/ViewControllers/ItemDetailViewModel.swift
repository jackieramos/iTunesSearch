//
//  ItemDetailViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation
import RxCocoa
import RxSwift

class ItemDetailViewModel {
    var item: BehaviorRelay<ItemTableViewCellModel>!
    
    let disposeBag = DisposeBag()
    
    init(item: ItemTableViewCellModel) {
        self.item = BehaviorRelay(value: item)
    }
}

extension ItemDetailViewModel {
    /// Mark item as favorite
    ///
    /// - Parameters:
    ///   - trackId: item's trackId
    ///   - isFavorite: true if user marks the item as favorite, false if user unfavorited the item
    func markItem(with trackId: Int64, asFavorite: Bool) {
        let result = CoreDataManager.shared.markItem(with: trackId, asFavorite: asFavorite)
        switch result {
        case .success(let item):
            self.item.accept(ItemTableViewCellModel(item: item))
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
