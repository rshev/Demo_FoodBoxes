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
    private let userDefaults: UserDefaults

    init(
        userDefaults: UserDefaults = .standard
    ) {
        self.userDefaults = userDefaults
    }

    var products: [Product] {
        get {
            userDefaults.decode(fromKey: #function) ?? []
        }
        set {
            userDefaults.encode(newValue, toKey: #function)
        }
    }
}

private extension UserDefaults {
    func decode<T: Decodable>(fromKey key: String) -> T? {
        guard let data = object(forKey: key) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func encode<T: Encodable>(_ value: T, toKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            set(data, forKey: key)
        } catch {
            assertionFailure("Failed to encode \(value) to key \(key)")
        }
    }
}
