//
//  MovieListViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation

class MovieListViewModel {
    
    var movies: [MovieCellViewModel] = []
    
    init(movies: [MovieCellViewModel]) {
        self.movies = movies
    }
    
    var cellIdentifier: String {
        return "ItemTableViewCell"
    }
}
