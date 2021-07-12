//
//  APIManager+Search.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/12/21.
//

extension APIManager {
    /// Search items.
    ///
    /// - Parameters:
    ///   - term: The URL-encoded text string you want to search for. For example: jack+johnson.
    ///   - countryCode: The two-letter country code for the store you want to search. The search uses the default store front for the specified country. For example: US. The default is US.
    ///   - media: The media type you want to search for. For example: movie. The default is all.
    static func searchItems(term: String, countryCode: String, media: String, completion:@escaping (Result<ItemList, AppError>)->Void) {
        request(route: SearchRoutes.searchItems(term: term, countryCode: countryCode, media: media), completion: completion)
    }
}
