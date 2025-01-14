//
//  APIMovieService.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 14/1/68 BE.
//

import Combine
import Foundation

protocol MovieAPIService {
    func getNowplaying() -> AnyPublisher<TrendingResults, APIError>
    func getTrendingList() -> AnyPublisher<TrendingResults, APIError>
    func getPopularMovies() -> AnyPublisher<TrendingResults, APIError>
    func getTopRatedMovies() -> AnyPublisher<TrendingResults, APIError>
    func getUpcomingMovies() -> AnyPublisher<TrendingResults, APIError>
    func searchTrending(query: String, pageIndex: Int) -> AnyPublisher<TrendingResults, APIError>
    
}
