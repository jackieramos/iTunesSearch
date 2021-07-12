//
//  MovieCellViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation

class MovieCellViewModel: ItemTableViewCellModel {
    
    var movie: Item!
    
    init(movie: Item) {
        self.movie = movie
        
        let formattedPrice = "\(movie.currency) \(movie.trackPrice)"
        let artworkImageUrl = URL(string: movie.artworkStringUrl)

        super.init(name: movie.trackName, price: formattedPrice, genre: movie.genre, artworkImageUrl: artworkImageUrl)
    }
    
    override var longDescription: String {
        return self.movie.longDescription
    }
}
