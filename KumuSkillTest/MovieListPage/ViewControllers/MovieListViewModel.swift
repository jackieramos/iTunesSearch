//
//  MovieListViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation
import RxCocoa
import RxSwift

class MovieListViewModel {
    
    var movies: BehaviorRelay<[MovieCellViewModel]> = BehaviorRelay(value: [])
    
    let disposeBag = DisposeBag()
    
    var cellIdentifier: String {
        return "ItemTableViewCell"
    }
}

//MARK: - API call
extension MovieListViewModel {
    func searchItems(term: String, countryCode: String, media: String) {
        APIManager.searchItems(term: term, countryCode: countryCode, media: media, completion: { response in
            switch response {
            case .success(let movieList):
                self.movies.accept(movieList.movies.map({MovieCellViewModel(movie: $0)}))
            case .failure(let error):
                print(error.debugDescription)
            }
        })
    }
}
