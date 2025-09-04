//
//  PostRepository.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//

import Foundation

class PostsRepository {
    private let remote = PostsRemoteDataSource()
    private let local =  PostsLocalDataSource()
    
    //Fetch users
    func fetchUsers() async throws -> [UserModal] {
        let users = try await remote.fetchUserList()
        return users
        
    }
  
    //Fetch post from localData and api based on a condition
    func fetchPosts(
        user: [Int: UserModal],
        onApiComplete: @escaping ([PostsModal]) -> Void
    ) async throws -> [PostsModal] {
        let localStoredData = local.loadPosts()
        if !localStoredData.isEmpty {
            Task {
                do {
                    let apiData = try await remote.fetchPostList()
                    local.saveAllPosts(apiData,users: user)
                    let localData = local.loadPosts()

                    DispatchQueue.main.async {
                        onApiComplete(localData)
                        }
                } catch {
                    print("API refresh failed: \(error)")
                }
            }
            return localStoredData
        } else {
            let posts = try await remote.fetchPostList()
            local.saveAllPosts(posts,users: user)
            return posts
        }
    }
    
    //Fetch post by id
    func fetchPostById(id:Int) async throws -> PostsModal {
        let post = try await remote.fetchPostDetail(id: id)
        return post
        
    }
}
