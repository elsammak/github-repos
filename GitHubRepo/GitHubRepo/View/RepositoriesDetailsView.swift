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
            
            Text("\(UILabelString.userNameTitle):   \(user.login)")
            Text("\(UILabelString.fullNameTitle):  \(user.name ?? "--")")
            Text("\(UILabelString.followersTitle) : \(user.followers ?? 0)")
            Text("\(UILabelString.followingTitle) : \(user.following ?? 0)")
            Spacer()
            
            Text(UILabelString.reposListTitle)
            .font(.headline)
            
            Text("\(UILabelString.displayedReposCount):  \(repositoryViewModel.reposArray.count)")
            
            // List of repos
            List {
                ForEach(Array(repositoryViewModel.reposArray.enumerated()), id: \.offset) { index, repo in
                    HStack {
                        
                        Text(repo.name)
                            .font(.subheadline)
                        Text(repo.language ?? "--")
                            .font(.subheadline)
                        Text("\(UILabelString.starsTitle): \(repo.stargazers_count)")
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
            .accessibilityIdentifier("ReposList")
            
        }
        .navigationTitle(user.login)
        .onAppear() {
            Task {
                await usersViewModel.getUserDetails(for: user)
                await repositoryViewModel.loadRepos(forUser: user.login)
            }
        }
        .onChange(of: usersViewModel.error ?? AppError()) { _,error in
            if error.errorMessage != nil {
                self.presentAlert = (error.errorMessage != nil)
            }
        }
        .showAlert(isPresented: $presentAlert, title: UILabelString.errorTitle, message: usersViewModel.error?.errorMessage ?? UILabelString.defaultErrorMessage)
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

