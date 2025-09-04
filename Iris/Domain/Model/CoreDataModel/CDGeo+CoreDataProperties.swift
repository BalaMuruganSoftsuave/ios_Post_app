//
//  CDGeo+CoreDataProperties.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
//

import Foundation
import CoreData


extension CDGeo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGeo> {
        return NSFetchRequest<CDGeo>(entityName: "CDGeo")
    }

    @NSManaged public var lat: String?
    @NSManaged public var lng: String?

}

extension CDGeo : Identifiable {

}
