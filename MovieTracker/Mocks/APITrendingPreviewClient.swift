//
//  APITrendingPreviewClient.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//

import Combine
import Foundation
struct APITrendingPreviewClient: MovieAPIService {
    
    func getNowplaying() -> AnyPublisher<TrendingResults, APIError> {
        guard let url = Bundle.main.url(forResource: "popular", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let trendingResults = try? JSONDecoder().decode(TrendingResults.self, from: data)
            
        else { fatalError("Unable to Load popular") }
        return Just(trendingResults)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    
    func getPopularMovies() -> AnyPublisher<TrendingResults, APIError> {
        guard let url = Bundle.main.url(forResource: "popular", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let trendingResults = try? JSONDecoder().decode(TrendingResults.self, from: data)
            
        else { fatalError("Unable to Load popular") }
        return Just(trendingResults)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func getTopRatedMovies() -> AnyPublisher<TrendingResults, APIError> {
        guard let url = Bundle.main.url(forResource: "topRated", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let trendingResults = try? JSONDecoder().decode(TrendingResults.self, from: data)
            
        else { fatalError("Unable to Load Top Rated") }
        return Just(trendingResults)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func getUpcomingMovies() -> AnyPublisher<TrendingResults, APIError> {
        guard let url = Bundle.main.url(forResource: "upcoming", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let trendingResults = try? JSONDecoder().decode(TrendingResults.self, from: data)
            
        else { fatalError("Unable to Load Upcoming") }
        return Just(trendingResults)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    
    
    func searchTrending(query: String, pageIndex: Int) -> AnyPublisher<TrendingResults, APIError> {
        guard let url = Bundle.main.url(forResource: "trending", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let trendingResults = try? JSONDecoder().decode(TrendingResults.self, from: data)
            
        else { fatalError("Unable to Load Trending") }
        return Just(trendingResults)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    
    func getTrendingList() -> AnyPublisher<TrendingResults, APIError> {
        guard let url = Bundle.main.url(forResource: "trending", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let trendingResults = try? JSONDecoder().decode(TrendingResults.self, from: data)
            
        else { fatalError("Unable to Load Trending") }
        return Just(trendingResults)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
