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
        super.init(item: movie)
    }
    
    override var longDescription: String {
        return self.movie.longDescription
    }
}
