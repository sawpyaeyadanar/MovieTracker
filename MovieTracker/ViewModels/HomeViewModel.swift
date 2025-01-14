//
//  HomeViewModel.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 11/1/68 BE.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var nowPlaying: [Movie] = []
    @Published var trendings: [Movie] = []
    @Published var upcomings: [Movie] = []
    @Published var populars: [Movie] = []
    @Published var toprateds: [Movie] = []
    @Published var searchResults: [Movie] = []
    @Published var errorMessage: String? = nil
    @Published var isOffline: Bool = true
    @Published var searchText: String = ""
    
    private let apiService: MovieAPIService
    //private let persistenceManager = PersistenceManager.shared
    private let persistenceManager: PersistenceManager
    private var subscriptions: Set<AnyCancellable> = []
    private let networkObserver = NetworkStatusObserver()
    
    var isFetching: Bool?
    
    init(apiService: MovieAPIService, persistenceManager: PersistenceManager) {
        self.apiService = apiService
        self.persistenceManager = persistenceManager
        setupNetworkBinding()
        loadnowplaying()
        loadTrending()
        loadPopular()
        loadTopRated()
        loadUpcoming()
        observeSearchText()
    }
    
    private func setupNetworkBinding() {
        networkObserver.$isOffline
            .assign(to: &$isOffline)
    }
    
    private func observeSearchText() {
        $searchText
            .debounce(for: (0.5), scheduler: RunLoop.main)
            .removeDuplicates() 
            .sink { [weak self] newText in
                guard let self, !newText.isEmpty else { return }
                self.searchItem(term: newText, pageIndex: 1)
            }
            .store(in: &subscriptions)
    }
    
    private func loadSavedTrendingMovies() {
        trendings = persistenceManager.fetchMovies(for: .trending)
        upcomings = persistenceManager.fetchMovies(for: .upcoming)
        populars = persistenceManager.fetchMovies(for: .popular)
        toprateds = persistenceManager.fetchMovies(for: .topRated)
        nowPlaying = persistenceManager.fetchMovies(for: .nowplaying)
    }
    
    func loadnowplaying() {
        guard !isOffline else {
            loadSavedTrendingMovies()
            return
        }
        isFetching = true
        apiService.getNowplaying()
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    self.errorMessage = ""
                    print("successfully load now playing")
                case .failure(let error):
                    print("unable to fetch \(error)")
                    self.errorMessage = error.message
                }
            } receiveValue: { [weak self] trendingResults in
                self?.nowPlaying = trendingResults.results
                self?.persistenceManager.saveNowPlaying(trendingResults.results)
            }.store(in: &subscriptions)
    }
    
    func loadTrending() {
        guard !isOffline else {
            loadSavedTrendingMovies()
            return
        }
        isFetching = true
        apiService.getTrendingList()
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    self.errorMessage = ""
                    print("successfully loadTrending")
                case .failure(let error):
                    print("unable to fetch \(error)")
                    self.errorMessage = error.message
                }
            } receiveValue: { [weak self] trendingResults in
                self?.trendings = trendingResults.results
                self?.persistenceManager.saveTrendingMovies(trendingResults.results)
            }.store(in: &subscriptions)
    }
    
    func loadUpcoming() {
        guard !isOffline else {
            loadSavedTrendingMovies()
            return
        }
        isFetching = true
        apiService.getUpcomingMovies()
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    //self.errorMessage = ""
                    print("successfully loadUpcoming")
                case .failure(let error):
                    print("unable to fetch \(error)")
                    //self.errorMessage = error.message
                }
            } receiveValue: { [weak self] trendingResults in
                self?.upcomings = trendingResults.results
                self?.persistenceManager.saveUpcomingMovies(trendingResults.results)
            }.store(in: &subscriptions)
    }
    
    func loadPopular() {
        guard !isOffline else {
            loadSavedTrendingMovies()
            return
        }
        isFetching = true
        apiService.getPopularMovies()
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    //self.errorMessage = ""
                    print("successfully loadPopular")
                case .failure(let error):
                    print("unable to fetch \(error)")
                    //self.errorMessage = error.message
                }
            } receiveValue: { [weak self] trendingResults in
                self?.populars = trendingResults.results
                self?.persistenceManager.savePopularMovies(trendingResults.results)
            }.store(in: &subscriptions)
    }
    
    func loadTopRated() {
        guard !isOffline else {
            loadSavedTrendingMovies()
            return
        }
        isFetching = true
        apiService.getTopRatedMovies()
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    //self.errorMessage = ""
                    print("successfully loadTopRated")
                case .failure(let error):
                    print("unable to fetch \(error)")
                    //self.errorMessage = error.message
                }
            } receiveValue: { [weak self] trendingResults in
                self?.toprateds = trendingResults.results
                self?.persistenceManager.saveTopRatedMovies(trendingResults.results)
            }.store(in: &subscriptions)
    }
    
    func searchItem(term: String, pageIndex: Int) { // private
        isFetching = true
        apiService.searchTrending(query: term, pageIndex: pageIndex)
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    print("search item successfully")
                    self.errorMessage = ""
                case .failure(let error):
                    print("unable to fetch \(error.message)")
                    self.errorMessage = error.message
                }
            } receiveValue: { [weak self] trendingResults in
                self?.searchResults = trendingResults.results
            }.store(in: &subscriptions)
    }
    
    func updateSearchText(_ newText: String) {
        searchText = newText
    }
}
