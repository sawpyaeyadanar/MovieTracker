//
//  PersistenceManager.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 12/1/68 BE.
//
import CoreData
import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    let container: NSPersistentContainer
    
    private init() {
        self.container = NSPersistentContainer(name: "MovieTracker")
        self.container.loadPersistentStores { description , error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            print("Core Data store URL: \(description.url?.absoluteString ?? "Unknown")")
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    // MARK: - Save Methods
    
    func saveNowPlaying(_ movies: [Movie]) {
        saveMovies(movies, category: .nowplaying)
    }
    
    func saveTrendingMovies(_ movies: [Movie]) {
        saveMovies(movies, category: .trending)
    }
    
    func savePopularMovies(_ movies: [Movie]) {
        saveMovies(movies, category: .popular)
    }
    
    func saveTopRatedMovies(_ movies: [Movie]) {
        saveMovies(movies, category: .topRated)
    }
    
    func saveUpcomingMovies(_ movies: [Movie]) {
        saveMovies(movies, category: .upcoming)
    }
    
    private func saveMovies(_ movies: [Movie], category: MovieCategory) {
        debugPrint("saveMovies \(category.rawValue)")
        for movie in movies {
            let entity = MovieCD(context: context) // Use the new name
            entity.id = Int64(movie.id)
            entity.title = movie.title
            entity.overview = movie.overview
            entity.posterPath = movie.poster_path
            entity.category = category.rawValue
            entity.release_date = movie.release_date
        }
        saveContext()
    }
    
    // MARK: - Fetch Methods
    
    func fetchMovies(for category: MovieCategory) -> [Movie] {
        let fetchRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category.rawValue)
        
        do {
            let savedEntities = try context.fetch(fetchRequest)
            
            return savedEntities.map { Movie(id: Int($0.id), poster_path: $0.posterPath ?? "", title: $0.title, vote_average: 1, overview: $0.overview ?? "", release_date: $0.release_date) }
        } catch {
            print("Failed to fetch movies for category \(category): \(error)")
            return []
        }
    }
    
    // MARK: - Save Context
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
