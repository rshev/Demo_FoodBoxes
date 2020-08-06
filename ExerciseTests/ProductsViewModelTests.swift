//
//  ProductsViewModelTests.swift
//  ExerciseTests
//
//  Created by Roman Shevtsov on 06/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import XCTest
@testable import Exercise

final class ProductsViewModelTests: XCTestCase {
    let api = APISpy()
    let localStorage = LocalStorageStub()
    let propagationQueue = DispatchQueue(label: "ProductsViewModelTests")

    private func newViewModel() -> ProductsViewModel {
        return ProductsViewModel(
            api: api,
            localStorage: localStorage,
            propagationQueue: propagationQueue
        )
    }

    func testViewModel_whenInitialized_productsAreReadFromLocalStorage() {
        let expectedProducts: [Product] = [.dummy]
        localStorage.products = expectedProducts

        let viewModel = newViewModel()

        XCTAssertEqual(viewModel.products, expectedProducts, "Products should be read from local storage immediately on init")
    }

    func testViewModel_whenAttached_apiShouldBeCalledAndProductsUpdatedInLocalStorageAndViewModel() {
        localStorage.products = []
        let expectedProductsResponse = ProductsResponse.dummy
        let expectedProducts = expectedProductsResponse.products
        api.stubbedRequests["GetProductsEndpoint"] = .success(expectedProductsResponse)

        let viewModel = newViewModel()
        viewModel.attach()

        // Wait for propagation queue to execute async blocks
        propagationQueue.sync {}

        XCTAssertTrue(api.invokedRequest, "API should be called")
        XCTAssertEqual(localStorage.products, expectedProducts, "Local storage should be updated with products from API")
        XCTAssertEqual(viewModel.products, expectedProducts, "View model should be updated with products from API")
    }
}

private extension ProductsResponse {
    static var dummy: Self {
        return ProductsResponse(products: [.dummy])
    }
}
