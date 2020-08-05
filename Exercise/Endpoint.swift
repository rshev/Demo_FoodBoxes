//
//  Endpoint.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

protocol Endpoint {
    associatedtype Response: Codable

    var urlPath: String { get }
    var httpMethod: HTTPMethod { get }
    func getRequest() throws -> Request?
}

enum Request {
    case queryParameters([URLQueryItem])
}

enum HTTPMethod: String {
    case GET
}
