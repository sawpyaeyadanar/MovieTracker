//
//  TrendingResults.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 11/1/68 BE.
//

import Foundation
struct TrendingResults: Decodable {

    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
