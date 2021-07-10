//
//  APIManager.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation
import Alamofire

class APIManager {
    
    ///Alamofire request
    ///
    /// - Parameters:
    ///   - route: Request route
    @discardableResult
    private static func performRequest<T:Decodable>(route:URLRequestConvertible, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (DataResponse<T, AFError>)->Void) -> DataRequest {

        let request = AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response)
        }
        
        //Comment out to log/print curl
        request.cURLDescription(calling: { desc in
            print(desc)
        })
        return request
    }

    /// Call to Alamofire request to catch  errors
    ///
    /// - Parameters:
    ///   - route: Request route
    @discardableResult
    static func request<T:Decodable>(route:URLRequestConvertible, completion:@escaping (Result<T, AppError>)->Void) -> DataRequest {
        
        performRequest(route: route, completion: { (response: DataResponse<T, AFError>)  in
            
            if let error = response.error {
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(AppError.badRequest))
                case 401:
                    completion(.failure(AppError.unauthorized))
                case 422:
                    completion(.failure(AppError.validationFailed))
                case 503:
                    completion(.failure(AppError.serviceUnavailable))
                default:
                    completion(.failure(AppError.requestError(error)))
                }
            } else {
                if let val = response.value {
                    completion(.success(val))
                }
            }
        })
    }

    /// Search repositories.
    ///
    /// - Parameters:
    ///   - queryString: Query String
    ///   - perPage: Number of items per page
    ///   - page: Page number
    static func searchItems(term: String, countryCode: String, media: String, completion:@escaping (Result<RepositoriesList, AppError>)->Void) {
        request(route: SearchRoutes.searchRepositories(q: queryString, perPage: perPage, page: page), completion: completion)
    }
}

