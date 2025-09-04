//
//  CDUsers+CoreDataProperties.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
//

import Foundation
import CoreData


extension CDUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUsers> {
        return NSFetchRequest<CDUsers>(entityName: "CDUsers")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?
    @NSManaged public var address: CDAddress?
    @NSManaged public var company: CDCompany?

}

extension CDUsers : Identifiable {

}
