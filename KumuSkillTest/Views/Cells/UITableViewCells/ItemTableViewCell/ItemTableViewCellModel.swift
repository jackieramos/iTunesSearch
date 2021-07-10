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
    let placeholderImage = UIImage(named: "placeholder")
    
    var longDescription: String {
        return ""
    }
    
    init(name: String, price: String, genre: String, artworkImageUrl: URL?) {
        self.genre = genre
        self.formattedPrice = price
        self.artworkImageUrl = artworkImageUrl
        super.init(title: name, subTitle: price)
    }
}
