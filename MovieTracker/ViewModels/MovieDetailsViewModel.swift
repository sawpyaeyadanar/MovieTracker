//
//  MovieDetailsViewModel.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//

import Foundation
import Combine

class MovieDetailsViewModel: ObservableObject {
    
    @Published var isOffline: Bool = true
    @Published var castProfiles = [CastProfile]()
    @Published var movieDetails: MovieDetails?
    
    var movie: Movie
    private var credits: MovieCredits?
    private var cast: [MovieCredits.Cast] = []
    var errorMessage: String?
    var isFetching: Bool = false
    var trailers: [Trailer]?
    
    
    private let apiService: APIDetailsService
    private var subscriptions: Set<AnyCancellable> = []
    private let networkObserver = NetworkStatusObserver()
    
    
    init(apiService: APIDetailsService, movie: Movie) {
        print("Initializing MovieDetailsViewModel for movie: \(movie.title ?? "Unknown")")
        self.apiService = apiService
        self.movie = movie
        setupNetworkBinding()
    }
    
    private func setupNetworkBinding() {
        networkObserver.$isOffline
            .assign(to: &$isOffline)
    }
    
    func getMovieCredit()  {
        isFetching = true
        apiService.getMovieCredit(for: movie.id)
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    print("successfully")
                    DispatchQueue.main.async {
                        self.isOffline = false
                        self.loadCastProfiles()
                    }
                case .failure(let error):
                    print("unable to fetch getMovieCredit \(error)")
                    if error == APIError.notConnectedToInternet {
                        self.isOffline = true
                    }
                    self.errorMessage = error.message
                }
            } receiveValue: { [weak self] credits in
                self?.credits = credits
                self?.cast = credits.cast.sorted(by: { $0.order < $1.order })
            }.store(in: &subscriptions)
    }
    
    func loadCastProfiles ()  {
        guard !cast.isEmpty else {
            print("No cast available to load profiles")
            return
        }
        
        let profilePublisher = Publishers.MergeMany(
            cast.map { member in
                apiService.loadCastProfiles(id: member.id)
                    .mapError { error in
                        print("Error fetching profile for \(member.name): \(error)")
                        return error
                    }
            }
        )
        
        profilePublisher
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                                print("Successfully loaded all cast profiles")
                            case .failure(let error):
                                print("Unable to fetch cast profiles: \(error)")
                                self.errorMessage = error.message
                }
            } receiveValue: { [weak self] profiles in
                DispatchQueue.main.async {
                    self?.castProfiles = profiles
                    print("Loaded profiles: \(profiles.count)")
                }
            }.store(in: &subscriptions)
    }
    
    func loadVideoList() {
            apiService.loadTrailers(for: movie.id)
                .sink { completion in
                    self.isFetching =  false
                    switch completion {
                    case .finished:
                        print("successfully")
                        self.loadCastProfiles()
                    case .failure(let error):
                        print("unable to fetch getMovieCredit \(error)")
                        self.errorMessage = error.message
                    }
                } receiveValue: { [weak self] trailers in
                    self?.trailers = trailers.results
                }.store(in: &subscriptions)
    }
    
    func loadMovieDetails() {
            apiService.loadMovieDetails(for: movie.id)
                .sink { completion in
                    self.isFetching =  false
                    switch completion {
                    case .finished:
                        print("successfully")
                        self.isOffline = false
                    case .failure(let error):
                        print("unable to fetch MovieDetails \(error)")
                        if error == APIError.notConnectedToInternet {
                            self.isOffline = true
                        }
                        self.errorMessage = error.message
                    }
                } receiveValue: { [weak self] details in
                    DispatchQueue.main.async {
                        self?.movieDetails = details
                    }
                }.store(in: &subscriptions)
    }
}
