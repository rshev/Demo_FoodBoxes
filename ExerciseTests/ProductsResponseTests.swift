//
//  ProductsResponseTests.swift
//  ExerciseTests
//
//  Created by Roman Shevtsov on 06/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import XCTest
@testable import Exercise

final class ProductsResponseTests: XCTestCase {
    func testDecoding_1productWithNoImages() throws {
        let json = """
        {
          "data": [
            {
              "id": "0009468c-33e9-11e7-b485-02859a19531d",
              "title": "Borsao Macabeo",
              "description": "A flavoursome Summer wine made from the indigenous Macabeo grape in northern Spain. A balanced, modern white with flavours of ripe peach, zesty lemon and nutty undertones, it leaves the palate with a clean and fruity finish.",
              "list_price": "6.95",
              "images": {
                "750": null
              }
            }
          ]
        }
        """
        let response = try ProductsResponse.decode(from: json)

        XCTAssertEqual(response.products.count, 1)
        let product = try XCTUnwrap(response.products.first)
        XCTAssertEqual(product.id, "0009468c-33e9-11e7-b485-02859a19531d")
        XCTAssertEqual(product.title, "Borsao Macabeo")
        XCTAssertEqual(product.description, "A flavoursome Summer wine made from the indigenous Macabeo grape in northern Spain. A balanced, modern white with flavours of ripe peach, zesty lemon and nutty undertones, it leaves the palate with a clean and fruity finish.")
        XCTAssertEqual(product.price, "6.95")
        XCTAssertNil(product.imageURL)
    }

    func testDecoding_1productWithImages() throws {
        let json = """
        {
          "data": [
            {
              "id": "0009468c-33e9-11e7-b485-02859a19531d",
              "title": "Borsao Macabeo",
              "description": "A flavoursome Summer wine made from the indigenous Macabeo grape in northern Spain. A balanced, modern white with flavours of ripe peach, zesty lemon and nutty undertones, it leaves the palate with a clean and fruity finish.",
              "list_price": "6.95",
              "images": {
                  "750": {
                    "src": "https://production-media.gousto.co.uk/cms/product-image-landscape/Domaine-de-LOlibet-Rose_Market-Place0594-x750.jpg",
                    "url": "https://production-media.gousto.co.uk/cms/product-image-landscape/Domaine-de-LOlibet-Rose_Market-Place0594-x750.jpg",
                    "width": 750
                  }
              }
            }
          ]
        }
        """
        let response = try ProductsResponse.decode(from: json)

        XCTAssertEqual(response.products.count, 1)
        let product = try XCTUnwrap(response.products.first)
        XCTAssertEqual(product.id, "0009468c-33e9-11e7-b485-02859a19531d")
        XCTAssertEqual(product.title, "Borsao Macabeo")
        XCTAssertEqual(product.description, "A flavoursome Summer wine made from the indigenous Macabeo grape in northern Spain. A balanced, modern white with flavours of ripe peach, zesty lemon and nutty undertones, it leaves the palate with a clean and fruity finish.")
        XCTAssertEqual(product.price, "6.95")
        XCTAssertEqual(product.imageURL, URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Domaine-de-LOlibet-Rose_Market-Place0594-x750.jpg")!)
    }

    func testDecoding_2products() throws {
        let json = """
        {
          "data": [
            {
              "id": "0009468c-33e9-11e7-b485-02859a19531d",
              "title": "Borsao Macabeo",
              "description": "A flavoursome Summer wine made from the indigenous Macabeo grape in northern Spain. A balanced, modern white with flavours of ripe peach, zesty lemon and nutty undertones, it leaves the palate with a clean and fruity finish.",
              "list_price": "6.95",
              "images": {}
            },
            {
              "id": "02c225f2-63b4-11e6-8516-023d2759e21d",
              "title": "Rioja Reserva, Baron de Ebro",
              "description": "Intriguing notes of vanilla and chocolate make this fruity, full-bodied wine unique. With a long, pleasant finish and woody aroma supporting it, this characterful wine is a good match with beef dishes. ABV 14%.",
              "list_price": "9.95",
              "images": {}
            }
          ]
        }
        """
        let response = try ProductsResponse.decode(from: json)

        XCTAssertEqual(response.products.count, 2)
    }
}

private extension Decodable {
    static func decode(from text: String) throws -> Self {
        let data = text.data(using: .utf8)!
        return try JSONDecoder().decode(Self.self, from: data)
    }
}
