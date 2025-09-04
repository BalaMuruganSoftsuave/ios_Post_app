//
//  PostView.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
import SwiftUI

struct PostView: View {
    let post: PostsModal
    let bgColor: Color
    var animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Circle()
                        .fill(bgColor.opacity(0.2))
                        .frame(width: 50, height: 50)
                    Text(getInitials(name: post.user?.name ?? ""))
                        .font(.title3)
                        .foregroundStyle(bgColor.opacity(1))
                }
                VStack(alignment: .leading) {
                    Text(post.user?.name ?? "")
                        .font(.headline)
                        .foregroundStyle(bgColor.opacity(1))
                    Text(post.user?.company?.name ?? "")
                        .font(.caption2)
                        .foregroundStyle(bgColor.opacity(0.8))
                }
            }
            .padding(.top, 5)
            
            HStack{
                Text(post.title ?? "")
                    .font(.caption)
                    .foregroundStyle(bgColor.opacity(0.8))
                    .padding(.vertical, 5)
                Spacer()
                HStack {
                    Text("View details")
                        .font(.subheadline)
                        .foregroundStyle(bgColor.opacity(0.8))
                        .padding(.vertical, 5)
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                        .frame(width:5,height: 5)
                }
                .padding(.horizontal, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .stroke(Color.white, lineWidth: 1)
                )
                
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [bgColor.opacity(0.4), bgColor.opacity(0.2)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .matchedGeometryEffect(id: post.id, in: animation)
    }
}
