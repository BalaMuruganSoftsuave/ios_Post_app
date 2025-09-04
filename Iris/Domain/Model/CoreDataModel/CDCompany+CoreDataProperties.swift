//
//  CDCompany+CoreDataProperties.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
//

import Foundation
import CoreData


extension CDCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCompany> {
        return NSFetchRequest<CDCompany>(entityName: "CDCompany")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String?

}

extension CDCompany : Identifiable {

}
