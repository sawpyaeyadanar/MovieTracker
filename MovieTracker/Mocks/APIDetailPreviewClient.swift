//
//  APIDetailPreviewClient.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//
import Combine
import Foundation

class APIDetailPreviewClient: APIDetailsService {
    func loadTrailers(for movieID: Int) -> AnyPublisher<Trailers, APIError> {
        let trailer = Trailers()
        return Just(trailer)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func loadMovieDetails(for movieID: Int) -> AnyPublisher<MovieDetails, APIError> {
        guard let url = Bundle.main.url(forResource: "details", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let movieDetails = try? JSONDecoder().decode(MovieDetails.self, from: data)
            
        else { fatalError("Unable to Load Movie Details") }
        return Just(movieDetails)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    
    func loadCastProfiles(id: Int) -> AnyPublisher<CastProfile, APIError> {
        guard let url = Bundle.main.url(forResource: "person", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let castProfile = try? JSONDecoder().decode(CastProfile.self, from: data)
            
        else { fatalError("Unable to Load Profile") }
        return Just(castProfile)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func getMovieCredit(for movieID: Int) -> AnyPublisher<MovieCredits, APIError> {
    
        guard let url = Bundle.main.url(forResource: "credits", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let credits = try? JSONDecoder().decode(MovieCredits.self, from: data)
            
        else { fatalError("Unable to Load Credits") }
        return Just(credits)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
