//
//  RemoteDataSource.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//

class PostsRemoteDataSource {
    //Fetch user list from api
    func fetchUserList() async throws -> [UserModal] {
        let users: [UserModal] = try await ApiService.request(
            from: ApiEndpoints.getUserList,
            as: [UserModal].self
        )
        return users;
    }
    //Fetch post list from api
    func fetchPostList() async throws -> [PostsModal] {
        let posts: [PostsModal] = try await ApiService.request(
            from: ApiEndpoints.getPostList,
            as: [PostsModal].self
        )
        return posts;
    }
    //Fetch post data from api
    func fetchPostDetail(id:Int) async throws -> PostsModal {
        let post: PostsModal = try await ApiService.request(
            from: ApiEndpoints.getPostDetail(id: id),
            as: PostsModal.self
        )
        return post;
    }
}
