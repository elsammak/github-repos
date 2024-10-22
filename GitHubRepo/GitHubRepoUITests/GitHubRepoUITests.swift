//
//  GitHubRepoUITests.swift
//  GitHubRepoUITests
//
//  Created by Mohammed Elsammak on 2024/10/20.
//

import XCTest

final class GitHubRepoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testUserListToRepositoryNavigation() throws {
        
        let app = XCUIApplication()
        app.launch()

        let usersListFirst = app.cells.firstMatch
        XCTAssertTrue(usersListFirst.waitForExistence(timeout: 5), "Expected at least one user to be displayed.")
        
        usersListFirst.tap()
        
        print(app.debugDescription)

        
        let reposList = app.collectionViews["ReposList"] // Access the list
        
        // Assert the list exists
        
        XCTAssertTrue(reposList.waitForExistence(timeout: 3), "The Repos List should be displayed.")
                
        
        // Check that it has some cells
        XCTAssertGreaterThan(reposList.cells.count, 0, "The list should contain some users")
        
        
    }
}
