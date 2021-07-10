//
//  Movie.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

struct MovieList: Decodable {
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movies = try container.decode([Movie].self, forKey: .results)
    }
}

struct Movie: Decodable {
    let trackId: Int
    let trackName: String
    let artworkStringUrl: String
    let genre: String
    let trackPrice: Float
    let currency: String
    let longDescription: String

    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case artworkStringUrl = "artworkUrl60"
        case genre = "primaryGenreName"
        case trackPrice
        case currency
        case longDescription
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        trackId = try container.decode(Int.self, forKey: .trackId)
        trackName = try container.decode(String.self, forKey: .trackName)
        artworkStringUrl = try container.decode(String.self, forKey: .artworkStringUrl)
        genre = try container.decode(String.self, forKey: .genre)
        trackPrice = try container.decode(Float.self, forKey: .trackPrice)
        currency = try container.decode(String.self, forKey: .currency)
        longDescription = try container.decode(String.self, forKey: .longDescription)
    }
}
