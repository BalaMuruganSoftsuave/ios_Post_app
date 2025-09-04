//
//  PostDetailsView.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
import SwiftUI

struct PostDetailsView: View {
    var animation: Namespace.ID
    var postId: Int
    var bgColor: Color
    var onClose: () -> Void
    @StateObject private var viewModel = PostDetailViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                ZStack {
                    Color.white
                            .ignoresSafeArea()
                    if viewModel.post == nil && !viewModel.isLoading {
                        VStack{
                            Image(systemName: "tray")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("No posts available")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    } else {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                bgColor.opacity(0.6),
                                bgColor.opacity(0.3)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .ignoresSafeArea(.container, edges: .top)
                        
                        VStack(spacing: 0) {
                            VStack {
                                HStack {
                                    Button(action: {
                                        onClose()
                                    }) {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.white)
                                            .padding(12)
                                            .background(Color.black.opacity(0.15))
                                            .clipShape(Circle())
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.top, 16)
                                
                                Spacer()
                                Text(viewModel.post?.title ?? "")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom, 60)
                                    .padding(.horizontal, 20)
                                Spacer()
                            }
                            .multilineTextAlignment(.center)
                            
                            
                            VStack(alignment: .leading, spacing: 24) {
                                HStack{
                                    ZStack{
                                        Circle()
                                            .fill(bgColor.opacity(0.2))
                                            .frame(width: 60, height: 60)
                                        Text(getInitials(name: viewModel.post?.user?.name ?? ""))
                                            .font(.title2)
                                            .foregroundStyle(bgColor.opacity(1))
                                    }
                                    VStack(alignment: .leading){
                                        Text( viewModel.post?.user?.name ?? "")
                                            .font(.title3)
                                            .foregroundStyle(bgColor.opacity(1))
                                        Text( viewModel.post?.user?.company?.name ?? "")
                                            .font(.body)
                                            .foregroundStyle(bgColor.opacity(0.8))
                                    }
                                }
                                .matchedGeometryEffect(id: viewModel.post?.id, in: animation)
                                .padding(.vertical)
                                
                                VStack(spacing: 20) {
                                    Text(viewModel.post?.body ?? "")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 32)
                                }
                               
                                
                                Spacer()
                            }
                            .padding(.horizontal, 24)
                            .background(Color.white)
                            .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                            .frame(height: geometry.size.height * 0.80)
                        }
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
            }
        }
        .background(.white)
        .navigationBarBackButtonHidden()
        .onAppear{
            Task {
                await viewModel.fetchPostById(id: postId)
            }
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
