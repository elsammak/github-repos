//
//  UsersViewModelTests.swift
//  GitHubRepoTests
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import XCTest
@testable import GitHubRepo

final class UsersViewModelTests: XCTestCase {

    var usersViewModel: UsersViewModel!
    var mockAPIClient: MockAPIClient!
    
    override func setUpWithError() throws {
        mockAPIClient = MockAPIClient()
        usersViewModel = UsersViewModel(apiClient: mockAPIClient)
    }

    override func tearDownWithError() throws {
        usersViewModel = nil
        mockAPIClient = nil
        super.tearDown()
    }

    
    func testLoadUsersSuccess() async {
            
        let mockUsers = [
            UserJSON(login: "user1", avatar_url: "url1", id: 1),
            UserJSON(login: "user2", avatar_url: "url2", id: 2)
        ]
        mockAPIClient.usersResult = .success((mockUsers, nil))

        await usersViewModel.loadUsers()

            
        XCTAssertFalse(usersViewModel.isLoading, "isLoading should be false")
        XCTAssertEqual(usersViewModel.users.count, 2, "There should be 2 users loaded")
        XCTAssertNil(usersViewModel.error, "Error should be nil")
    }
    
    func testLoadUsersFailure() async {
        mockAPIClient.usersResult = .failure(.unknownError("API Error"))
            
        await usersViewModel.loadUsers()
            
        XCTAssertEqual(usersViewModel.users.count, 0)
        XCTAssertEqual(usersViewModel.error?.errorDescription!, "API Error")
    }

    func testGetUserDetailsSuccess() async {
        let user = UserJSON(login: "user1", avatar_url: "url1", id: 1)
        usersViewModel.users = [user]
            
        let updatedUser = UserJSON(login: "user1", avatar_url: "url1", id: 1, name: "Updated Name")
        mockAPIClient.userDetailsResult = .success(updatedUser)
                        
        await usersViewModel.getUserDetails(for: user)
                        
        XCTAssertEqual(usersViewModel.users.first?.name, "Updated Name")
        XCTAssertNil(usersViewModel.error)
    }

    func testGetUserDetailsFailure() async {
        
        let user = UserJSON(login: "user1", avatar_url: "url1", id: 1)
        usersViewModel.users = [user]
                    
        mockAPIClient.userDetailsResult = .failure(.unknownError("User Details Error"))
                        
        await usersViewModel.getUserDetails(for: user)
                                
        XCTAssertEqual(usersViewModel.error?.errorDescription!, "User Details Error")
        }
}
