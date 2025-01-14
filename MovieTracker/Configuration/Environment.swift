//
//  Environment.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 11/1/68 BE.
//

import Foundation
enum URLManager {
    static var apiBaseURL: URL {
        URL(string: "https://api.themoviedb.org/3/")!
    }
    
    static var apiKey: String {
        "9f04c49e56282d595c3ac1fa31ea742d"
    }
}
