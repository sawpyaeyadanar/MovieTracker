//
//  APIClient.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 11/1/68 BE.
//
import Combine
import Foundation

class APIClient: MovieAPIService {
    func getNowplaying() -> AnyPublisher<TrendingResults, APIError> {
        APIService.shared.request(.now_playing)
    }
    
    func getPopularMovies() -> AnyPublisher<TrendingResults, APIError> {
        APIService.shared.request(.popular)
    }
    
    func getTopRatedMovies() -> AnyPublisher<TrendingResults, APIError> {
        APIService.shared.request(.topRated)
    }
    
    func getUpcomingMovies() -> AnyPublisher<TrendingResults, APIError> {
        APIService.shared.request(.upcoming)
    }
    
    func searchTrending(query: String, pageIndex: Int) -> AnyPublisher<TrendingResults, APIError> {
           return APIService.shared.request(.search, parameters:
                                        [
                                            "language": "en-US",
                                            "page": "\(pageIndex)",
                                            "include_adult": "false",
                                            "query": "\(query)"
                                        ])
    }

    func getTrendingList() -> AnyPublisher<TrendingResults, APIError> {
        APIService.shared.request(.trending)
    }
   
}

extension APIClient: APIDetailsService {
    
    func loadTrailers(for movieID: Int) -> AnyPublisher<Trailers, APIError> {
        APIService.shared.request(.search)
    }
    
    func loadMovieDetails(for movieID: Int) -> AnyPublisher<MovieDetails, APIError> {
        APIService.shared.request(.details(id: movieID))
    }
    
    func getMovieCredit(for movieID: Int) -> AnyPublisher<MovieCredits, APIError> {
        APIService.shared.request(.credits(id: movieID))
    }
    
    func loadCastProfiles(id: Int) -> AnyPublisher<CastProfile, APIError> {
        APIService.shared.request(.person(id: id))
    }

}
