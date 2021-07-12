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
                    let result = CoreDataManager.shared.saveItem(storeItem: item)
                    switch result {
                    case .success(_):
                        print("Success")
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
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
        let result = CoreDataManager.shared.getItems()
        switch result {
        case .success(let items):
            let items = items.map({MovieCellViewModel(movie: $0)})
            self.movies.accept(items)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}

