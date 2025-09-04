//
//  ApiErrorCases.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
import Foundation

//Contains all the error
enum ErrorCase: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case custom(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid Api URL"
        case .invalidResponse:
            return "Invalid Api Response"
        case .invalidData:
            return "Invalid data"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
