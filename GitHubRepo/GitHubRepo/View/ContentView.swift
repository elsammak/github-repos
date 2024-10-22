//
//  ContentView.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import SwiftUI
// Parent view, should contain and manage all subviews
struct ContentView: View {

    var body: some View {
        NavigationStack() {
            UsersListView()
        }
      
    }
}

#Preview {    
    ContentView()
}

