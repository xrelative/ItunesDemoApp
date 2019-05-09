//
//  SearcherWireframe.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import UIKit

protocol Wireframe {}

class SearcherWireframe: Wireframe {
    static func assemble() -> UIViewController {
        let dataSource = ItunesDataSource()
        let repository = SearcherRepository(dataSource: dataSource)
        let interactor = SearcherInteractor(repository: repository)
        let presenter = SearcherPresenter(interactor: interactor)
        interactor.delegate = presenter
        let viewController = SearcherViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
