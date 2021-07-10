//
//  MovieListViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

class MovieListViewModel {
    var movieViewModels: [MovieViewModel] = []

    init(list: MovieList) {
        self.movieViewModels = list.movies.map{ MovieViewModel(movie: $0) }
    }
}
