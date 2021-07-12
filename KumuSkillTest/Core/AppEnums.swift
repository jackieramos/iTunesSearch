//
//  ItemType.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation

enum ItemType {
    case movie
    case podcast
    case music
    case musicVideo
    case audioBook
    case shortFilm
    case tvShow
    case software
    case ebook
}

enum AppPage: Int16 {
    case itemList = 0
    case itemDetail = 1
    case favoriteItemList = 2
}
