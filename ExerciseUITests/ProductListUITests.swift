//
//  ProductListUITests.swift
//  UITests
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import XCTest

struct ProductListPage: Page {
    var app: XCUIApplication

    var distinctElement: XCUIElementQuery {
        return app.buttons.matching(identifier: "product row")
    }

    func goTo() {
        // NOOP, the app starts on this page
    }

    var searchBar: XCUIElement {
        return app.otherElements["search bar"]
    }

    var productRow: XCUIElement {
        return distinctElement.firstMatch
    }
}

final class ProductListUITests: XCTestCase {
    let app = XCUIApplication()
    lazy var page = ProductListPage(app: app)

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testProductListLoadsAndContainsProducts() {
        page.goTo()
        page.assertIsCurrent()
        XCTAssertTrue(page.searchBar.exists, "Search bar should exist")

        // Unfortunately Swift UI doesn't expose nested accessibility elements of a Button/NavigationLink
    }
}
