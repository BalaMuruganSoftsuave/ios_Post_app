//
//  CDAddress+CoreDataProperties.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
//

import Foundation
import CoreData


extension CDAddress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAddress> {
        return NSFetchRequest<CDAddress>(entityName: "CDAddress")
    }

    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var geo: CDGeo?

}

extension CDAddress : Identifiable {

}
