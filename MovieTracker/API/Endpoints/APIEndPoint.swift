//
//  APIEndPoint.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 11/1/68 BE.
//

import Foundation
enum APIEndPoint {
    // MARK: - Cases
    case trending
    case credits( id: Int)
    case search
    case person(id: Int)
    case details(id: Int)
    case popular
    case topRated
    case upcoming
    case now_playing


    
    // MARK: - Properties
    var urlComponent: URLComponents {
        URLComponents(url: URLManager.apiBaseURL, resolvingAgainstBaseURL: false)!
        
    }

     var path: String {
        switch self {
        case .trending:
            return "trending/all/day"
        case let .credits( movieID):
             return "movie/\(movieID)/credits"
        case .search:
            return "search/movie"
        case let .person(id):
            return "person/\(id)"
        case .details(id: let movieID):
            return "movie/\(movieID)"
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .now_playing:
            return "movie/now_playing"
        }
    }
    
    var headers: Headers {
        [
            "Content-Type" : "application/json"
        ]
    }
    
     var httpMethod: HttpMethod {
        switch self {
        case .trending, .credits(_), .search, .person(_), .details(_):
            return .get
        case .popular, .topRated, .upcoming, .now_playing:
            return .get
        
        }
    }
    
}
 extension URLRequest {
    mutating func addHeaders(_ headers: Headers) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }
}

