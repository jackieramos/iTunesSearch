//
//  FavoritesListViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/12/21.
//

import Foundation
import RxCocoa
import RxSwift

class FavoritesListViewModel {
    
    var favoriteMovies: BehaviorRelay<[MovieCellViewModel]> = BehaviorRelay(value: [])
    
    let disposeBag = DisposeBag()
    
    var cellIdentifier: String {
        return "ItemTableViewCell"
    }
}

//MARK: - Core data call
extension FavoritesListViewModel {
    func getFavoriteItems() {
        let result = CoreDataManager.shared.getFavoriteItems()
        switch result {
        case .success(let items):
            let items = items.map({MovieCellViewModel(movie: $0)})
            self.favoriteMovies.accept(items)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}
