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
    @NSManaged var isFavorite: Bool
    
    var toDictionary: [String: Any] {
        return [K.APIParameterKey.trackId: self.trackId,
                K.APIParameterKey.trackName: self.trackName,
                K.APIParameterKey.artworkStringUrl: self.artworkStringUrl,
                K.APIParameterKey.genre: self.genre,
                K.APIParameterKey.trackPrice: self.trackPrice,
                K.APIParameterKey.currency: self.currency,
                K.APIParameterKey.longDescription: self.longDescription,
                K.APIParameterKey.isFavorite: self.isFavorite]
    }

    enum CodingKeys: String, CodingKey {
        case trackId, trackName, trackPrice, currency, longDescription
        case artworkStringUrl = "artworkUrl100"
        case genre = "primaryGenreName"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: K.CoreDataEntity.item, in: context) else { fatalError() }

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
    
    convenience init(trackId: Int64, trackName: String, artworkStringUrl: String, genre: String, trackPrice: Float, currency: String, longDescription: String, isFavorite: Bool) {
        
        let context = CoreDataManager.shared.container.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: K.CoreDataEntity.item, in: context) else { fatalError() }

        self.init(entity: entity, insertInto: context)
        
        self.trackId = trackId
        self.trackName = trackName
        self.artworkStringUrl = artworkStringUrl
        self.genre = genre
        self.trackPrice = trackPrice
        self.currency = currency
        self.longDescription = longDescription
        self.isFavorite = isFavorite
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let trackId = dictionary[K.APIParameterKey.trackId] as? Int64, let trackName = dictionary[K.APIParameterKey.trackName] as? String, let artworkUrlString = dictionary[K.APIParameterKey.artworkStringUrl] as? String, let genre = dictionary[K.APIParameterKey.genre] as? String, let trackPrice = dictionary[K.APIParameterKey.trackPrice] as? Float, let currency = dictionary[K.APIParameterKey.currency] as? String, let longDescription = dictionary[K.APIParameterKey.longDescription] as? String, let isFavorite = dictionary[K.APIParameterKey.isFavorite] as? Bool else {
            return nil
        }
        self.init(trackId: trackId, trackName: trackName, artworkStringUrl: artworkUrlString, genre: genre, trackPrice: trackPrice, currency: currency, longDescription: longDescription, isFavorite: isFavorite)
    }
}
