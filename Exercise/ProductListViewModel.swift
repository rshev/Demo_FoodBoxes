//
//  ProductListViewModel.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    private let api: APIProvider
    private let localStorage: LocalStorageProvider

    init(
        api: APIProvider = API(baseURL: Configuration.apiBaseURL),
        localStorage: LocalStorageProvider = LocalStorage()
    ) {
        self.api = api
        self.localStorage = localStorage

        products = localStorage.products
    }

    @Published var products: [Product]

    func attach() {
        let endpoint = GetProductsEndpoint()
        api.request(endpoint) { [weak self] (result) in
            switch result {
            case .failure:
                // TODO: handle error
                break
            case .success(let response):
                self?.products = response.products
                self?.localStorage.products = response.products
            }
        }
    }
}
