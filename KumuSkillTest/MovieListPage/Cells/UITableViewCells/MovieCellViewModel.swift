//
//  MovieCellViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation

class MovieCellViewModel: ItemTableViewCellModel {
    init(movie: Movie) {
        let formattedPrice = "\(movie.currency) \(movie.trackPrice)"
        let artworkImageUrl = URL(string: movie.artworkStringUrl)

        super.init(name: movie.trackName, price: formattedPrice, genre: movie.genre, artworkImageUrl: artworkImageUrl, longDescription: movie.longDescription)
    }
}
