//
//  Networking.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import UIKit

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

extension UIImageView {
    func loadFromUrl(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }

    func loadFromUrlString(from urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: urlString) else { return }
        loadFromUrl(from: url, contentMode: mode)
    }
}

