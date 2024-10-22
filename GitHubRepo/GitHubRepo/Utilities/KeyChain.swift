//
//  KeyChain.swift
//  GitHubRepo
//
//  Created by Mohammed Elsammak on 2024/10/22.
//

// This is to allow accessing tokens from Keychain as Environment variables aee only accessed from Xcode
import Security
import Foundation
func saveToKeychain(token: String) {
    let tokenData = token.data(using: .utf8)!
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrAccount: "GitHubToken",
        kSecValueData: tokenData
    ] as CFDictionary

    SecItemAdd(query, nil)
}

func getTokenFromKeychain() -> String? {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrAccount: "GitHubToken",
        kSecReturnData: true,
        kSecMatchLimit: kSecMatchLimitOne
    ] as CFDictionary

    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query, &dataTypeRef)

    if status == errSecSuccess {
        if let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
    }
    return nil
}
