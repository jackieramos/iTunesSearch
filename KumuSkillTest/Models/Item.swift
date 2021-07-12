//
//  Movie.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit
import CoreData

struct ItemList: Decodable {
    let movies: [Item]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movies = try container.decode([Item].self, forKey: .results)
    }
}

@objc(Item)
public class Item: NSManagedObject, Decodable {
    @NSManaged var trackId: Int64
    @NSManaged var trackName: String
    @NSManaged var artworkStringUrl: String
    @NSManaged var genre: String
    @NSManaged var trackPrice: Float
    @NSManaged var currency: String
    @NSManaged var longDescription: String

    enum CodingKeys: String, CodingKey {
        case trackId, trackName, trackPrice, currency, longDescription
        case artworkStringUrl = "artworkUrl100"
        case genre = "primaryGenreName"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: context) else { fatalError() }

        self.init(entity: entity, insertInto: context)
        
        let id = try container.decode(Int.self, forKey: .trackId)
        trackId = Int64(id)
        trackName = try container.decode(String.self, forKey: .trackName)
        artworkStringUrl = try container.decode(String.self, forKey: .artworkStringUrl)
        genre = try container.decode(String.self, forKey: .genre)
        trackPrice = try container.decode(Float.self, forKey: .trackPrice)
        currency = try container.decode(String.self, forKey: .currency)
        longDescription = try container.decode(String.self, forKey: .longDescription)
    }
}
