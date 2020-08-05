//
//  ProductsResponse.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

struct ProductsResponse: Codable {
    var products: [Product]

    enum CodingKeys: String, CodingKey {
        case products = "data"
    }
}

struct Product: Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var price: String
    var images: [URL] {
        return _images.values.map(\.url)
    }

    // MARK: Private transformations

    private var _images: [String: Image]

    struct Image: Codable {
        var url: URL
    }

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case price = "list_price"
        case _images = "images"
    }
}
