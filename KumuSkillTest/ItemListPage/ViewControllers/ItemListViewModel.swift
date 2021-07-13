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
    var lastPageIndex: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    var pageStates: [PageState] = []
    var pageState: PageState!
    
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
                self.saveLastState()
            case .failure(let error):
                print(error.debugDescription)
            }
        })
    }
}

//MARK: - Core data call
extension ItemListViewModel {
    func getAllPageLastState() {
        let result = CoreDataManager.shared.getAllPageSate()
        switch result {
        case .success(let pageStates):
            self.pageStates = pageStates
            let dates = pageStates.map({$0.lastVisitedDate}).compactMap { lastVisitedDateInString -> Date? in
                return lastVisitedDateInString.toDate()
            }
            if dates.count > 0 {
                let mostRecent = dates.reduce(dates[0], { $0.timeIntervalSince1970 > $1.timeIntervalSince1970 ? $0 : $1 } )
                self.lastPageIndex.accept(dates.firstIndex(of: mostRecent) ?? 0)
            }
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getLastState() {
        let result = CoreDataManager.shared.getPageSate(pageId: AppPage.itemList.rawValue)
        switch result {
        case .success(let pageState):
            self.pageState = pageState
            let lastStateItems = pageState.viewModel.compactMap { itemsDict -> MovieCellViewModel? in
                if let item = Item(dictionary: itemsDict) {
                    return MovieCellViewModel(movie: item)
                }
                return nil
            }
            self.movies.accept(lastStateItems)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func saveLastState() {
        let itemsArray = self.movies.value.map({$0.item.toDictionary})
        let pageState = PageState(pageId: AppPage.itemList.rawValue, lastVisitedDate: Date().stringFormat("MM/dd/YY hh:mm:ss a"), viewModel: itemsArray)
        let result = CoreDataManager.shared.savePageState(page: pageState)
        switch result {
        case .success(_):
            print("Success saving state")
        case .failure(let error):
            print("Error saving state: \(error.localizedDescription)")
        }
    }
}

