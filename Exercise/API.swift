//
//  API.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

protocol APIProvider: AnyObject {
    func request<E: Endpoint>(_ endpoint: E, completion: @escaping (Result<E.Response, Error>) -> Void)
}

enum APIError: Error {
    case statusCodeNotSuccess
    case noResponseBody
    case cannotFormatURL
}

final class API: APIProvider {
    private let urlSession: URLSession
    private let baseURL: URL

    init(
        urlSession: URLSession = .shared,
        baseURL: URL
    ) {
        self.urlSession = urlSession
        self.baseURL = baseURL
    }

    func request<E: Endpoint>(
        _ endpoint: E,
        completion: @escaping (Result<E.Response, Error>) -> Void
    ) {
        do {
            let request = try endpoint.urlRequest(withBaseURL: baseURL)
            urlSession.dataTask(
                with: request,
                completionHandler: { (data, response, error) in
                    do {
                        if let error = error {
                            throw error
                        }
                        guard response?.isHttpStatusCodeSuccessful == true else {
                            throw APIError.statusCodeNotSuccess
                        }
                        guard let data = data else {
                            throw APIError.noResponseBody
                        }
                        let response = try JSONDecoder().decode(E.Response.self, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(error))
                    }
                }
            ).resume()
        } catch {
            completion(.failure(error))
        }
    }
}

extension Endpoint {
    func urlRequest(
        withBaseURL baseURL: URL
    ) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(urlPath)
        let request = try getRequest()

        var urlRequest: URLRequest

        switch request {
        case .none:
            urlRequest = URLRequest(url: url)
        case .queryParameters(let items):
            let url = try url.replacingQueryItems(items)
            urlRequest = URLRequest(url: url)
        }

        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
}

private extension URLResponse {
    var isHttpStatusCodeSuccessful: Bool {
        guard let httpURLResponse = self as? HTTPURLResponse else {
            return false
        }
        return (200...299).contains(httpURLResponse.statusCode)
    }
}

private extension URL {
    func replacingQueryItems(_ queryItems: [URLQueryItem]) throws -> URL {
        guard
            var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)
        else {
            throw APIError.cannotFormatURL
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            throw APIError.cannotFormatURL
        }
        return url
    }
}
