//
//  MovieCD+CoreDataProperties.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//
//

import Foundation
import CoreData


extension MovieCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCD> {
        return NSFetchRequest<MovieCD>(entityName: "MovieCD")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?
    @NSManaged public var release_date: String?

}

extension MovieCD : Identifiable {

}
