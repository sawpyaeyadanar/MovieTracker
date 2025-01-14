//
//  Movie.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 11/1/68 BE.
//

import Foundation

struct Movie: Identifiable, Codable, Equatable {
    let id: Int
    let poster_path: String?
    let title: String?
    let vote_average: Float
    let overview: String
    let release_date: String?
    
    var backdropURL: URL? {
        guard let poster_path = poster_path, !poster_path.isEmpty else {
            return nil
        }
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w200/")
        return baseURL?.appending(path: poster_path )
    }
    
    var formattedReleaseDate: String? {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd-MM-yyyy"

            if let release_date, let date = inputFormatter.date(from: release_date) {
                return outputFormatter.string(from: date)
            }
            return release_date // Fallback to original if parsing fails
        }
    
    var year: String? {
        release_date?.split(separator: "-").first.map { String($0)}
    }
    
    static var mock: Movie {
        Movie(id: 2321, poster_path: "/vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg", title: "Heart of Stone", vote_average: 7.8, overview: "An intelligence operative for a shadowy global peacekeeping agency races to stop a hacker from stealing its most valuable — and dangerous — weapon.", release_date: "2025-01-09")
    }
}
