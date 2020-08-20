//
//  LocalStorage.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

protocol LocalStorageProvider: AnyObject {
    var products: [Product] { get set }
}

final class LocalStorage: LocalStorageProvider {
    init() {}

    private lazy var fileManager = FileManager.default
    private var cachesDirectory: URL? {
        try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    private func cacheURL(withFilename filename: String) -> URL? {
        cachesDirectory?.appendingPathComponent("\(filename).json")
    }

    var products: [Product] {
        get {
            guard
                let url = cacheURL(withFilename: #function),
                let data = try? Data(contentsOf: url),
                let products = try? JSONDecoder().decode([Product].self, from: data)
            else {
                return []
            }
            return products
        }
        set {
            do {
                guard let url = cacheURL(withFilename: #function) else {
                    throw URLError(.badURL)
                }
                let data = try JSONEncoder().encode(newValue)
                try data.write(to: url, options: .atomicWrite)
            } catch {
                assertionFailure("Cannot encode/store data")
            }
        }
    }
}
