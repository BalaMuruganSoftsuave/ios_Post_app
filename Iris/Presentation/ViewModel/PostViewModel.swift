//
//  PostViewModel.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
import Foundation
import SwiftUI

@MainActor
final class PostViewModel: ObservableObject {
    static let shared = PostViewModel()
        private init() {}
    
    @Published var users: [Int: UserModal] = [:]
    @Published var errorValue: ErrorCase?
    @Published var isLoading = false
    @Published var posts: [PostsModal] = []
    let postColor: [Color] = [.red, .blue, .purple, .pink, .green, .orange, .brown, .cyan]

    private let repository = PostsRepository()
    
    // Fetch users from repo and add it in dictionary
    func getUsers() async {
        isLoading = true
        do {
            let usersList = try await repository.fetchUsers()
            let dict = Dictionary(uniqueKeysWithValues: usersList.map { ($0.id ?? -1, $0) })
                self.users = dict
                await getPostList()
            self.isLoading = false

        } catch(let error) {
            errorValue = ErrorCase.custom(error: error)
            self.isLoading = false

        }
    }
    
    //Fetch post list from repo
    func getPostList() async {
        posts=[];
        do {
            posts = try await repository.fetchPosts(user: users,onApiComplete: { [weak self] updatedPosts in
                Task { @MainActor in
                        self?.posts = updatedPosts
                    }
            })
            self.isLoading = false

        } catch(let error) {
            errorValue = ErrorCase.custom(error: error)
            self.isLoading = false

        }
    
    }
    
    //Generate color for posts
    func getColor(id: Int) -> Color {
        return postColor[id%8]
    }
}
