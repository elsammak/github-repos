//
//  AlertView.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/22.
//

import SwiftUI

struct AlertView: ViewModifier {
    @Binding var isPresented: Bool
    var title: String
    var message: String
    var dismissButton: Alert.Button

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: dismissButton
                )
            }
    }
}
