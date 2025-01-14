//
//  Trailers.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//

import Foundation
struct Trailers: Codable {
    var id      : Int?       = nil
    var results : [Trailer]? = []
}

struct Trailer: Codable {
    var iso6391     : String?
    var iso31661    : String?
    var name        : String?
    var key         : String?
    var site        : String?
    var size        : Int?
    var type        : String?
    var official    : Bool?
    var publishedAt : String?
    var id          : String?
}
