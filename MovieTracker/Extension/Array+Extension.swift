//
//  Array+Extension.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 14/1/68 BE.
//

import Foundation
extension Array where Element: Identifiable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element.ID>()
        return filter { movie in
            guard !seen.contains(movie.id) else { return false }
            seen.insert(movie.id)
            return true
        }
    }
}
