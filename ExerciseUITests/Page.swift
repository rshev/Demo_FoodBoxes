//
//  Page.swift
//  ExerciseUITests
//
//  Created by Roman Shevtsov on 06/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import XCTest

protocol Page {
    var app: XCUIApplication { get }

    var distinctElement: XCUIElementQuery { get }

    func assertIsCurrent()
    func goTo()
}

extension Page {
    func assertIsCurrent() {
        XCTAssert(distinctElement.firstMatch.waitForExistence(timeout: 5))
    }
}
