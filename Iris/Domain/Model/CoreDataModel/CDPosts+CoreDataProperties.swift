//
//  CDPosts+CoreDataProperties.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
//

import Foundation
import CoreData


extension CDPosts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPosts> {
        return NSFetchRequest<CDPosts>(entityName: "CDPosts")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var userId: Int64
    @NSManaged public var user: CDUsers?

}

extension CDPosts : Identifiable {

}
