//
//  ProductsEndpoint.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

struct GetProductsEndpoint: Endpoint {
    private enum Constant {
        static let imageSizesQueryItem = URLQueryItem(name: "image_sizes[]", value: "750")
    }

    typealias Response = ProductsResponse

    let httpMethod: HTTPMethod = .GET
    let urlPath: String = "/products/v2.0/products"

    func getRequest() throws -> Request? {
        return .queryParameters([
            Constant.imageSizesQueryItem,
        ])
    }
}
