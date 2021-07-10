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
        }
    }
}
