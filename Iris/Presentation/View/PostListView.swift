//
//  PostListView.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
import SwiftUI

struct PostListView: View {
    @Namespace private var animation
    @StateObject private var viewModel = PostViewModel.shared
    
    @State private var selectedPost: PostsModal?
    @State private var selectedColor: Color = .blue
    @State private var showDetail = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Posts")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                
                ScrollView {
                    if viewModel.posts.isEmpty && !viewModel.isLoading {
                        VStack{
                            Image(systemName: "tray")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("No posts available")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    } else {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.posts) { post in
                                let color = viewModel.getColor(id: post.id ?? 1 )
                                
                                PostView(post: post, bgColor: color, animation: animation)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                            selectedPost = post
                                            selectedColor = color
                                            showDetail = true
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .refreshable {
                    Task{
                        await viewModel.getUsers()
                    }
                }
                
                
            }
            
            if let selectedPost, showDetail {
                PostDetailsView(
                    animation: animation,
                    postId: selectedPost.id ?? 1,
                    bgColor: selectedColor
                ) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        showDetail = false
                    }
                }
                .zIndex(1)
            }
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
        }
        .onAppear{
            Task{
                await viewModel.getUsers()
            }
        }
    }
}
