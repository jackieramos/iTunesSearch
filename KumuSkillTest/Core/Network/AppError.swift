//
//  AppError.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import Foundation
import Alamofire

enum AppError: Error {
    case badRequest
    case unauthorized
    case validationFailed
    case serviceUnavailable
    case requestError(AFError)
    case notFound
    case entityNotFound(_ entityName: String)
    case failed(Error)
}

extension AppError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Forbidden"
        case .validationFailed:
            return "Validation Failed"
        case .serviceUnavailable:
            return "Service Unavailable"
        case let .requestError(error):
            return error.localizedDescription
        case .notFound:
            return "Not found"
        case let .entityNotFound(entityName):
            return "\(entityName) not found"
        case let .failed(error):
            return "Could not fetch: \(error.localizedDescription)"
        }
    }
}
