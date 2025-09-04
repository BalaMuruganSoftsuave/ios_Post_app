//
//  Helper.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//


public func getInitials(name: String) -> String {
    let nameLetterParts = name
        .split(separator: " ")
        .map { String($0) }
    guard let firstLetter = nameLetterParts.first else { return "" }
    var initials = String(firstLetter.prefix(1))
        if let lastLetter = nameLetterParts.dropFirst().first {
        initials += String(lastLetter.prefix(1))
    }
    return initials.uppercased()
}
