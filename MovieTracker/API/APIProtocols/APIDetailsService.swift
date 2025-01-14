//
//  APIDetailsService.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 11/1/68 BE.
//

import Combine
import Foundation
protocol APIDetailsService {
    func getMovieCredit(for movieID: Int) -> AnyPublisher<MovieCredits, APIError>
    func loadCastProfiles(id: Int) -> AnyPublisher<CastProfile, APIError>
    func loadTrailers(for movieID: Int) -> AnyPublisher<Trailers, APIError>
    func loadMovieDetails(for movieID: Int) -> AnyPublisher<MovieDetails, APIError>
}
