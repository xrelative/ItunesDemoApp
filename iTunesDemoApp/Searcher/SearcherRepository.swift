//
//  SearcherRepository.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/8/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import Foundation

protocol SearcherRepositoryProtocol: Repository {
    func getResults(value: String, completion: @escaping (Result<ApiResponse, Error>) -> Void)
}

class SearcherRepository: SearcherRepositoryProtocol {
    let dataSource: ItunesDataSourceProtocol

    init(dataSource: ItunesDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func getResults(value: String, completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        dataSource.getResults(value: value, completion: completion)
    }
}
