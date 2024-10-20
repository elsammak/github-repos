//
//  UsersListView.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import SwiftUI

struct UsersListView: View {
    
    @ObservedObject var usersViewModel = UsersViewModel() 
    
    var body: some View {
            List {
                ForEach(Array(usersViewModel.users.enumerated()), id: \.offset) { index, user in
                    HStack {
                        AsyncImage(url: URL(string: user.avatar_url)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        
                        Text(user.login)
                            .font(.headline)
                    }
                    .onAppear {
                        // Trigger loading of next page if this is the last user
                        if index == usersViewModel.users.count - 1 {
                            Task {
                                await usersViewModel.loadUsers() // Load rest page
                            }
                        }
                    }
                }
                
                if usersViewModel.isLoading {
                    ProgressView() // Show loading indicator
                }
            }
            .onAppear {
                Task {
                    await usersViewModel.loadUsers() // Load initial page
                }
            }
        }
}


#Preview {
    UsersListView()
}
