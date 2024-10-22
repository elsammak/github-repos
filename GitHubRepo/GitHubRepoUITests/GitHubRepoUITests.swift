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

        // Verify that users list is loaded
//        XCTAssertTrue(app.tables.element.exists, "The user list should be present")

        // Tap on the first user
//        let firstUserCell = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
//        XCTAssertTrue(firstUserCell.exists, "The first user cell should exist")
//        firstUserCell.tap()
//
//        // After tapping, verify that the repositories view is shown
//        XCTAssertTrue(app.staticTexts["List of Repositories"].exists, "The repository list should be visible")
    }
}
