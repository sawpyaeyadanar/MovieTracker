//
//  MovieDetails.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//

import Foundation

struct MovieDetails: Codable, Equatable {
    
    var adult               : Bool?
    var backdropPath        : String?
    var budget              : Int?
    var genres              : [Genres]?
    var homepage            : String?
    var id                  : Int?
    var imdbId              : String?
    var originCountry       : [String]?
    var originalLanguage    : String?
    var originalTitle       : String?
    var overview            : String?
    var popularity          : Double?
    var posterPath          : String?
    var releaseDate         : String?
    var revenue             : Int?
    var runtime             : Int?
    var status              : String?
    var tagline             : String?
    var title               : String?
    var video               : Bool?
    var voteAverage         : Double?
    var voteCount           : Int?
    
}


struct Genres: Codable, Identifiable, Hashable {
    let id : Int
    let name : String?
}
