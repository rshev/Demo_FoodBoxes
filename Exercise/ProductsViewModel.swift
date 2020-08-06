//
//  ProductsViewModel.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

final class ProductsViewModel: ObservableObject {
    private let api: APIProvider
    private let localStorage: LocalStorageProvider
    private let propagationQueue: DispatchQueue

    init(
        api: APIProvider = API(baseURL: Configuration.apiBaseURL),
        localStorage: LocalStorageProvider = LocalStorage(),
        propagationQueue: DispatchQueue = .main
    ) {
        self.api = api
        self.localStorage = localStorage
        self.propagationQueue = propagationQueue

        products = localStorage.products
    }

    @Published private(set) var products: [Product]

    func attach() {
        let endpoint = GetProductsEndpoint()
        api.request(endpoint) { [weak self] (result) in
            switch result {
            case .failure:
                // TODO: handle error
                break
            case .success(let response):
                self?.updateProducts(with: response.products)
            }
        }
    }

    private func updateProducts(with products: [Product]) {
        // A chance to filter / process products
        localStorage.products = products
        // UI should be updated (via Combine) on main queue
        propagationQueue.async { [weak self] in
            self?.products = products
        }
    }
}
