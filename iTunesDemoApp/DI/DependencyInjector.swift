//
//  DependencyInjector.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/13/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import Foundation

class DependencyInjector {
    static var shared: DependencyInjector = {
        DependencyInjector()
    }()

    lazy var itunesDataSource: ItunesDataSourceProtocol = {
        return ItunesDataSource()
    }()

    func searcherRepository(dataSource: ItunesDataSourceProtocol) -> SearcherRepositoryProtocol {
        return SearcherRepository(dataSource: dataSource)
    }

    func searcherInteractor(repository: SearcherRepositoryProtocol) -> SearcherInteractorProtocol {
        return SearcherInteractor(repository: repository)
    }

    func searcherPresenter(interactor: SearcherInteractorProtocol) -> SearcherPresenterProtocol {
        return SearcherPresenter(interactor: interactor)
    }

    func searcherViewController(presenter: SearcherPresenterProtocol) -> SearcherViewController {
        return SearcherViewController(presenter: presenter)
    }
}
