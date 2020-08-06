//
//  Fakes.swift
//  ExerciseTests
//
//  Created by Roman Shevtsov on 06/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import XCTest
@testable import Exercise

final class APISpy: APIProvider {
    var invokedRequest = false
    var invokedRequestCount = 0
    var stubbedRequests: [String: Result<Codable, Error>] = [:]

    func request<E: Endpoint>(_ endpoint: E, completion: @escaping (Result<E.Response, Error>) -> Void) {
        invokedRequest = true
        invokedRequestCount += 1
        let endpointType = String(describing: type(of: endpoint))
        if let result = stubbedRequests[endpointType] {
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let value):
                if let value = value as? E.Response {
                    completion(.success(value))
                } else {
                    XCTFail("Supplied wrong type of response for \(endpointType)")
                }
            }
        } else {
            XCTFail("Could not find stubbed endpoint \(endpointType)")
        }
    }
}

final class LocalStorageStub: LocalStorageProvider {
    var products: [Product] = []
}
