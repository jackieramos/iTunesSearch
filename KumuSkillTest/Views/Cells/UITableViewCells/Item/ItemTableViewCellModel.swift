//
//  ItemTableViewCellModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation
import UIKit

class ItemTableViewCellModel: BaseCellViewModel {
    var genre: String
    var formattedPrice: String
    var artworkImageUrl: URL?
    var longDescription: String
    let placeholderImage = UIImage(named: "placeholder")
    
    init(name: String, price: String, genre: String, artworkImageUrl: URL?, longDescription: String) {
        self.genre = genre
        self.formattedPrice = price
        self.artworkImageUrl = artworkImageUrl
        self.longDescription = longDescription
        super.init(title: name, subTitle: price)
    }
}
