//
//  ApiEndPoints.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
import Foundation

//Contains all the endpoints
enum ApiEndpoints{
        
    private static let hostUrl = "https://jsonplaceholder.typicode.com"
      
        static var getPostList: String {
            return "\(hostUrl)/posts"
        }
        
        static func getPostDetail(id: Int) -> String {
            return "\(hostUrl)/posts/\(id)"
        }
        
        static var getUserList: String {
            return "\(hostUrl)/users"
        }
    
}
