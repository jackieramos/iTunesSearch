//
//  MovieViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation

class MovieViewModel {
    var movie: Movie!

    init(movie: Movie) {
        self.movie = movie
    }

    var trackName: String {
        return movie.trackName
    }

    var artworkUrl: URL? {
        return URL(string: movie.artworkStringUrl)
    }

    var genre: String {
        return movie.genre
    }

    var formattedPrice: String {
        return "\(movie.currency) \(movie.trackPrice)"
    }

    var longDescription: String {
        return movie.longDescription
    }
}
