//
//  RepositoriesDetailsView.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import SwiftUI

struct RepositoriesDetailsView: View {
    var user: UserJSON
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.avatar_url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            
            Text(user.login)
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle(user.login)
    }
}

#Preview {
    let mockUser = UserJSON(login: "MockUser", avatar_url: "https://example.com/avatar.png", id: 12345)
    RepositoriesDetailsView(user: mockUser)
}
