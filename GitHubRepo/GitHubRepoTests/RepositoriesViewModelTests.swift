//
//  RepositoriesViewModelTests.swift
//  GitHubRepoTests
//
//  Created by Mohammed Elsammak on 2024/10/22.
//

import XCTest
@testable import GitHubRepo

final class RepositoriesViewModelTests: XCTestCase {

    var repositoriesViewModel: RepositoriesViewModel!
    var mockAPIClient: MockAPIClient!
    
    override func setUpWithError() throws {
        
        mockAPIClient = MockAPIClient()
        repositoriesViewModel = RepositoriesViewModel(apiClient: mockAPIClient)
    }

    override func tearDownWithError() throws {
        repositoriesViewModel = nil
        mockAPIClient = nil
        super.tearDown()
    }


    func testLoadReposSuccess() async {
            
        let mockRepos = [
            RepoJSON(id: 1, name: "Repo1", language: "Swift", stargazers_count: 100, description: "Test repo"),
            RepoJSON(id: 2, name: "Repo2", language: "Objective-C", stargazers_count: 50, description: "Another test repo")
        ]
        mockAPIClient.repoResult = .success((mockRepos, nil))

        await repositoriesViewModel.loadRepos(forUser: "UserName")

            
        XCTAssertFalse(repositoriesViewModel.isLoading, "isLoading should be false")
        XCTAssertEqual(repositoriesViewModel.reposArray.count, 2, "There should be 2 users loaded")
        XCTAssertNil(repositoriesViewModel.error, "Error should be nil")
    }
    
    // Test handling pagination
    func testLoadReposWithPagination() async {
            // Given
        let initialRepos = [
            RepoJSON(id: 1, name: "Repo1", language: "Swift", stargazers_count: 100, description: "Test repo")
        ]
        let paginatedRepos = [
            RepoJSON(id: 2, name: "Repo2", language: "Objective-C", stargazers_count: 50, description: "Another test repo")
        ]
        
        mockAPIClient.repoResult = .success((initialRepos, nil))
        mockAPIClient.nextUserUrl = "nextPageUrl"
                        
        await repositoriesViewModel.loadRepos(forUser: "UserName")
            
            // Simulate loading the next page
        mockAPIClient.repoResult = .success((paginatedRepos, nil))
        await repositoriesViewModel.loadRepos(forUser: "UserName")
            
            // Then
        XCTAssertEqual(repositoriesViewModel.reposArray.count, 2, "There should be 2 repositories after pagination")
        XCTAssertEqual(repositoriesViewModel.reposArray[1].name, "Repo2", "Second repo's name should be 'Repo2'")
        }
}
