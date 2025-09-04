//
//  CDUsers+CoreDataProperties.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
//

import Foundation

struct PostsModal: Codable ,Identifiable{
    let userId, id: Int?
    let title, body: String?
    var user: UserModal?

}
