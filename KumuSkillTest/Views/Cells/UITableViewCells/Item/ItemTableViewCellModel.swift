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
    var artworkImageUrl: URL?
    
    init(name: String, price: String, genre: String, artworkImageUrl: URL?) {
        self.genre = genre
        self.artworkImageUrl = artworkImageUrl
        super.init(title: name, subTitle: price)
    }
}
