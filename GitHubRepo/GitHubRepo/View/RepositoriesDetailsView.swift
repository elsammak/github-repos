//
//  RepositoriesDetailsView.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import SwiftUI

struct RepositoriesDetailsView: View {
    
    var user: UserJSON
    @StateObject var repositoryViewModel = RepositoriesViewModel()
    @ObservedObject var usersViewModel: UsersViewModel
    @State private var presentAlert = false
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: user.avatar_url)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            }
            
            Text("Username: \(user.login)")
            Text("Full Name:\(user.name ?? "--")")
            Text("Number of Followers:\(user.followers ?? 0)")
            Text("Number of Following:\(user.following ?? 0)")
            Spacer()
            
            Text("List of Repositories")
            .font(.headline)
            
            Text("Count of repo \(repositoryViewModel.reposArray.count)")
            
            // List of repos
            List {
                ForEach(Array(repositoryViewModel.reposArray.enumerated()), id: \.offset) { index, repo in
                    HStack {
                        
                        Text(repo.name)
                            .font(.subheadline)
                        Text(repo.language ?? "--")
                            .font(.subheadline)
                        Text("Stars: \(repo.stargazers_count)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(repo.description ?? "--")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                    }
                    .onAppear {
                        // Trigger loading of next page if this is the last user
                        if index == repositoryViewModel.reposArray.count - 1 {
                            Task {
                                await repositoryViewModel.loadRepos(forUser: user.login) // Load rest page
                            }
                        }
                    }
                }
                
                if repositoryViewModel.isLoading {
                    ProgressView() // Show loading indicator
                }
            }
            
            // end of list
            
        }
        .navigationTitle(user.login)
        .onAppear() {
            Task {
                await usersViewModel.getUserDetails(for: user)
                await repositoryViewModel.loadRepos(forUser: user.login)
            }
        }
        .onChange(of: usersViewModel.error?.errorMessage) { _,errorMessage in
            if errorMessage != nil {
                self.presentAlert = (errorMessage == nil)
            }
        }
        .showAlert(isPresented: $presentAlert, title: "Error", message: usersViewModel.error?.errorMessage ?? "Unknown Error")
    }
}

#Preview {
    let mockUser = UserJSON(
        login: "mockUser",
        avatar_url: "https://avatars.githubusercontent.com/u/1?v=4", // Use a valid image URL
        id: 1
    )
    
    let mockUsersViewModel = UsersViewModel()
    let mockRepositoriesViewModel = RepositoriesViewModel()
    
    RepositoriesDetailsView(user: mockUser, repositoryViewModel: mockRepositoriesViewModel, usersViewModel: mockUsersViewModel)
}

