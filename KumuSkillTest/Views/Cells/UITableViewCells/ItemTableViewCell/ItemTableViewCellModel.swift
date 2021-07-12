//
//  ItemTableViewCellModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation
import UIKit

class ItemTableViewCellModel: BaseCellViewModel {
    
    var item: Item!

    var longDescription: String {
        return ""
    }
    
    var artworkUrl: URL? {
        return URL(string: item.artworkStringUrl)
    }
    
    init(item: Item) {
        self.item = item
        let formattedPrice = "\(item.currency) \(item.trackPrice)"
        super.init(title: item.trackName, subTitle: formattedPrice)
    }
}
