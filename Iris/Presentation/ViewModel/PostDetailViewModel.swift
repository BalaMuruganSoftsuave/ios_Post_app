//
//  PostDetailViewModel.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
import Foundation

@MainActor
final class PostDetailViewModel: ObservableObject {
    
    @Published var post: PostsModal?
    @Published var errorValue: ErrorCase?
    @Published var isLoading = false
    private let repository = PostsRepository()
    private let postViewModel = PostViewModel.shared
    
    //Fetch post with post id
    func fetchPostById(id:Int) async {
        isLoading = true
        do {
            var data = try await repository.fetchPostById(id: id)
            if let userId = data.userId {
                data.user = postViewModel.users[userId]
            }
            self.post=data
            self.isLoading = false
        } catch(let error) {
            errorValue = ErrorCase.custom(error: error)
            isLoading = false
        }
    }
}
