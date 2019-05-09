//
//  Networking.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case url
    case serverError
    case noResults
    case invalidJsonSchema
    case unknownError
}

struct Endpoint {
    private static var hostBase: URLComponents {
        var base = URLComponents()
        base.scheme = "https"
        base.host = "itunes.apple.com"
        return base
    }

    private static let searchEndpoint = "/search"
    private static let termParameter = "term"

    static func search(value: String) -> URL? {
        var searchUrl = hostBase
        searchUrl.path = searchEndpoint
        searchUrl.queryItems = [
            URLQueryItem(name: termParameter, value: value)
        ]
        return searchUrl.url
    }
}
