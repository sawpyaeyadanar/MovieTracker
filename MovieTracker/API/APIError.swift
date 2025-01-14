//
//  APIError.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 11/1/68 BE.
//

import Foundation
enum APIError: Error, Equatable {

    
    
    case invalidURL
    case failedRequest
    case notConnectedToInternet
    case dataCorrupted(DecodingError.Context)
    case decodingKeyNotFoundError(key: CodingKey, context: String)
    case decodingValueNotFoundError(key: Any.Type, context: String)
    case decodingTypeMismatchError(key: Any.Type, context: String)
   
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.failedRequest, .failedRequest),
            (.notConnectedToInternet, .notConnectedToInternet):
            return true
        case let (.dataCorrupted(context1), .dataCorrupted(context2)):
            return context1.debugDescription == context2.debugDescription
        case let (.decodingKeyNotFoundError(key1, context1), .decodingKeyNotFoundError(key2, context2)):
            return key1.stringValue == key2.stringValue && context1 == context2
        case let (.decodingValueNotFoundError(type1, context1), .decodingValueNotFoundError(type2, context2)):
            return type1 == type2 && context1 == context2
        case let (.decodingTypeMismatchError(type1, context1), .decodingTypeMismatchError(type2, context2)):
            return type1 == type2 && context1 == context2
        default:
            return false
        }
    }
        
        var message: String {
            switch self {
            case .failedRequest:
                return "Failed to fetch data"
            case .notConnectedToInternet:
                return "Check the internet connection"
            case let .dataCorrupted(context):
                return "\(context.debugDescription)"
            case .decodingKeyNotFoundError(key: let key, context: let context):
                return "Key \(key) not found:, \(context.debugDescription)"
            case .decodingValueNotFoundError(key: let key, context: let context):
                return "Key \(key) not found:, \(context.debugDescription)"
            case .decodingTypeMismatchError(key: let key, context: let context):
                return "Key \(key) not found:, \(context.debugDescription)"
            case .invalidURL:
                return "URL is incorrect"
            }
        }
    }

enum LocalError: Error{
    
    case saveError
    case readError
    
    var message: String {
        switch self {
        case .saveError:
            return "Could not save it, please reinstall the app"
        case .readError:
            return "Could not load it, please reinstall the app"
        }
    }
}
