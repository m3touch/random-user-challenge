//
//  RandomUserChallengeUITests.swift
//  RandomUserChallengeUITests
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 martatarrago. All rights reserved.
//

import XCTest
@testable import RandomUserChallenge

class RandomUserChallengeUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.launchArguments = ["isUITesting", "resetPersistance"]
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() { }

    func testCanShowRandomUserDetail() {
        let firstRandomUserCell = app.tables.element(boundBy: 0).descendants(matching: .cell).element(boundBy: 0)
        firstRandomUserCell.tap()

        let userNameAndSurname = "Aquira Jesus"
        let detailNavigationBar = app.navigationBars.element(boundBy: 0)
        waitToAppear(detailNavigationBar, errorMessage: "Random user detail is not appearing")

        XCTAssert(detailNavigationBar.identifier == userNameAndSurname)
    }

    func testFilterRandomUserByName() {
        let userName = "Aquira"

        let searchBar = app.searchFields.element(boundBy: 0)
        searchBar.tap()
        searchBar.typeText(userName)

        let keyboard = app.keyboards.element(boundBy: 0)
        let searchButton = keyboard.buttons.matching(identifier: "Search").element
        searchButton.tap()

        let table = app.tables.element(boundBy: 0)
        XCTAssertTrue(table.descendants(matching: .cell).count == 1)

        let firstCell = table.descendants(matching: .cell).element(boundBy: 0)
        let firstCellUserName = firstCell.staticTexts.element(boundBy: 0)
        XCTAssertTrue(firstCellUserName.label.contains(userName))

        searchBar.tap()
        searchBar.typeText("a")
        searchButton.tap()
        XCTAssertTrue(app.staticTexts["Nothing to see yet"].isHittable)
    }

    func testFilterRandomUserBySurname() {

        let userSurname = "Jesus"

        let searchBar = app.searchFields.element(boundBy: 0)
        searchBar.tap()
        searchBar.typeText(userSurname)

        let segmentedControl = app.segmentedControls.element(boundBy: 0)
        let surnameFilter = segmentedControl.buttons.element(boundBy: 1)
        surnameFilter.tap()

        let table = app.tables.element(boundBy: 0)
        XCTAssertTrue(table.descendants(matching: .cell).count == 1)

        let firstCell = table.descendants(matching: .cell).element(boundBy: 0)
        let firstCellUserName = firstCell.staticTexts.element(boundBy: 0)
        XCTAssertTrue(firstCellUserName.label.contains(userSurname))

        searchBar.tap()
        searchBar.typeText("a")
        let keyboard = app.keyboards.element(boundBy: 0)
        let searchButton = keyboard.buttons.matching(identifier: "Search").element
        searchButton.tap()
        XCTAssertTrue(app.staticTexts["Nothing to see yet"].isHittable)
    }

    func testFilterRandomUserByEmail() {
        let userEmail = "aquira.jesus"

        let searchBar = app.searchFields.element(boundBy: 0)
        searchBar.tap()
        searchBar.typeText(userEmail)

        let segmentedControl = app.segmentedControls.element(boundBy: 0)
        let emailFilter = segmentedControl.buttons.element(boundBy: 2)
        emailFilter.tap()

        let table = app.tables.element(boundBy: 0)
        XCTAssertTrue(table.descendants(matching: .cell).count == 1)

        let firstCell = table.descendants(matching: .cell).element(boundBy: 0)
        let firstCellEmail = firstCell.staticTexts.element(boundBy: 1)
        XCTAssertTrue(firstCellEmail.label.contains(userEmail))

        searchBar.tap()
        searchBar.typeText("a")
        let keyboard = app.keyboards.element(boundBy: 0)
        let searchButton = keyboard.buttons.matching(identifier: "Search").element
        searchButton.tap()
        XCTAssertTrue(app.staticTexts["Nothing to see yet"].isHittable)
    }

    func testDeleteRandomUser() {
        let userNameAndSurname = "Aquira Jesus"

        let usersTable = app.tables.element(boundBy: 0)
        let firstCell = usersTable.descendants(matching: .cell).element(boundBy: 0)
        firstCell.swipeLeft()

        let deleteButton = firstCell.buttons.element(boundBy: 0)
        deleteButton.tap()

        let deleteAlert = app.alerts.element(boundBy: 0)
        let alertMessage = deleteAlert.staticTexts.element(boundBy: 1)

        XCTAssertTrue(alertMessage.label.contains(userNameAndSurname.lowercased()))

        let dismissButton = deleteAlert.buttons.element(boundBy: 0)
        dismissButton.tap()

        XCTAssertTrue(usersTable.descendants(matching: .cell).count == 2)

        app.launchArguments = ["isUITesting"]
        app.launch()
        XCTAssertTrue(usersTable.descendants(matching: .cell).count == 2)
    }
}
