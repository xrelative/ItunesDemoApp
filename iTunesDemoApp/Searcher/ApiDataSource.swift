//
//  ApiDataSource.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/8/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import Foundation

protocol ItunesDataSourceProtocol: DataSource {
    func getResults(value: String, completion: @escaping (Result<ApiResponse, Error>) -> Void)
}

class ItunesDataSource: ItunesDataSourceProtocol {
    func getResults(value: String, completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        guard let url = Endpoint.search(value: value) else {
            completion(.failure(NetworkError.url))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.serverError))
                return
            }

            if let data = data {
                do {
                    let dataResponse = try JSONDecoder().decode(ApiResponse.self, from: data)

                    if dataResponse.resultCount > 0 {
                        completion(.success(dataResponse))
                    } else if dataResponse.resultCount == 0 {
                        completion(.failure(NetworkError.noResults))
                    } else if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(NetworkError.unknownError))
                    }
                } catch {
                    completion(.failure(NetworkError.invalidJsonSchema))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
