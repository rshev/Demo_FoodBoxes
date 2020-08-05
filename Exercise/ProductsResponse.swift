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

struct Product: Codable, Equatable, Hashable, Identifiable {
    var id: String
    var title: String
    var description: String
    var price: String
    var images: [URL] {
        return _images.values.compactMap({ $0 }).map(\.url)
    }

    // MARK: Private transformations

    private var _images: [String: Image?]

    struct Image: Codable, Equatable, Hashable {
        var url: URL
    }

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case price = "list_price"
        case _images = "images"
    }
}

// MARK: - Preview mocks

#if DEBUG
extension Product {
    static var dummy: Product {
        return Product(
            id: UUID().uuidString,
            title: "Dummy product",
            description: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            """,
            price: "3.99",
            _images: [
                "750" : Image(url: URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Salted-Caramel-Popcorn-0659-x750.jpg")!),
            ]
        )
    }
}
#endif
