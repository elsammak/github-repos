//
//  ViewExtentions.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/22.
//

import SwiftUI
extension View {
    func showAlert(isPresented: Binding<Bool>, title: String, message: String, dismissButton: Alert.Button = .default(Text("OK"))) -> some View {
        self.modifier(AlertView(isPresented: isPresented, title: title, message: message, dismissButton: dismissButton))
    }
}
