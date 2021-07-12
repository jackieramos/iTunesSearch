//
//  MovieListViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation
import RxCocoa
import RxSwift

class ItemListViewModel {
    
    var movies: BehaviorRelay<[MovieCellViewModel]> = BehaviorRelay(value: [])
    
    let disposeBag = DisposeBag()
    
    var cellIdentifier: String {
        return "ItemTableViewCell"
    }
}

//MARK: - API call
extension ItemListViewModel {
    func searchItems(term: String, countryCode: String, media: String) {
        APIManager.searchItems(term: term, countryCode: countryCode, media: media, completion: { response in
            switch response {
            case .success(let movieList):
                self.movies.accept(movieList.movies.map({ item in
                    CoreDataManager.shared.save(storeItem: item)
                    return MovieCellViewModel(movie: item)
                }))
            case .failure(let error):
                print(error.debugDescription)
            }
        })
    }
}

//MARK: - Core data call
extension ItemListViewModel {
    func getItems() {
        let items = CoreDataManager.shared.get().map({MovieCellViewModel(movie: $0)})
        self.movies.accept(items)
    }
}

