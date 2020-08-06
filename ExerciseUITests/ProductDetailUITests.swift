//
//  ProductListPage.swift
//  ExerciseUITests
//
//  Created by Roman Shevtsov on 06/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import XCTest

struct ProductDetailPage: Page {
    var app: XCUIApplication

    var distinctElement: XCUIElementQuery {
        return app.scrollViews.matching(identifier: "product detail")
    }

    func goTo() {
        let productListPage = ProductListPage(app: app)
        productListPage.goTo()
        productListPage.assertIsCurrent()
        productListPage.productRow.tap()
    }

    var image: XCUIElement {
        return app.images["image"]
    }

    var titleText: XCUIElement {
        return app.staticTexts["title"]
    }

    var priceText: XCUIElement {
        return app.staticTexts["price"]
    }

    var descriptionText: XCUIElement {
        return app.staticTexts["description"]
    }

    var navigationBackButton: XCUIElement {
        return app.navigationBars.buttons.firstMatch
    }
}

final class ProductDetailUITests: XCTestCase {
    let app = XCUIApplication()
    lazy var page = ProductDetailPage(app: app)

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testProductDetailPageContainsAllElements() {
        page.goTo()
        page.assertIsCurrent()

        XCTAssertTrue(page.image.exists)
        XCTAssertTrue(page.titleText.exists)
        XCTAssertTrue(page.priceText.exists)
        XCTAssertTrue(page.descriptionText.exists)
    }

    func testGoingBackLeadsToProductListPage() {
        page.goTo()
        page.assertIsCurrent()

        page.navigationBackButton.tap()

        let productListPage = ProductListPage(app: app)
        productListPage.assertIsCurrent()
    }
}
