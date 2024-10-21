//
//  RepositoriesDetailsView.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import SwiftUI

struct RepositoriesDetailsView: View {
    
    var user: UserJSON
    @ObservedObject var repositoryViewModel = RepositoriesViewModel()

    
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
        .onAppear() {
            Task {
                await repositoryViewModel.loadRepos(forUser: user.login)
            }
        }
    }
}

#Preview {
    let mockUser = UserJSON(login: "mojombo", avatar_url: "https://avatars.githubusercontent.com/u/1?v=", id: 1)
    RepositoriesDetailsView(user: mockUser)
}
