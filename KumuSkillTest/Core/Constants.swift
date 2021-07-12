//
//  Constants.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

struct K {
    struct iTunesServer {
        static let baseURL = "https://itunes.apple.com"
    }
    
    struct APIParameterKey {
        static let term = "term"
        static let countryCode = "country"
        static let media = "media"
        static let trackId = "trackId"
        static let trackName = "trackName"
        static let artworkStringUrl = "artworkStringUrl"
        static let currency = "currency"
        static let trackPrice = "trackPrice"
        static let genre = "genre"
        static let longDescription = "longDescription"
        static let isFavorite = "isFavorite"
    }
    
    struct CoreDataEntity {
        static let item = "Item"
    }
    
    static let appName = "KumuSkillTest"
}
