//
//  SearcherWireframe.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import UIKit
import Swinject

class SearcherWireframe: Wireframe {
    private lazy var container: Container = {
        let container = Container()
        container.register(ItunesDataSourceProtocol.self) { _ in
            ItunesDataSource()
        }
        container.register(SearcherRepositoryProtocol.self) { r in
            SearcherRepository(dataSource: r.resolve(ItunesDataSourceProtocol.self)!)
        }
        container.register(SearcherInteractorProtocol.self) { r in
            SearcherInteractor(repository: r.resolve(SearcherRepositoryProtocol.self)!)
        }
        container.register(SearcherPresenterProtocol.self) { r in
            SearcherPresenter(interactor: r.resolve(SearcherInteractorProtocol.self)!)
        }
        container.register(SearcherViewController.self) { r in
            SearcherViewController(presenter: r.resolve(SearcherPresenterProtocol.self)!)
        }
        return container
    }()

    func assemble() -> UIViewController {
        return container.resolve(SearcherViewController.self)!
    }
}
