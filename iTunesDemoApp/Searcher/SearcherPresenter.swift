//
//  SearcherPresenter.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/8/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

protocol SearcherPresenterProtocol: Presenter, SearcherInteractorDelegate {
    var view: SearcherView? { get set }
    func getResults(value: String)
}

protocol SearcherView: class {
    func showResults(_ results: [ResultRow])
    func showError(_ error: Error)
}

class SearcherPresenter: SearcherPresenterProtocol {
    private let interactor: SearcherInteractorProtocol
    weak var view: SearcherView?

    init(interactor: SearcherInteractorProtocol) {
        self.interactor = interactor
        self.interactor.delegate = self
    }

    func getResults(value: String) {
        interactor.getResults(value: value)
    }
}

extension SearcherPresenter: SearcherInteractorDelegate {
    func showResults(_ results: [ResultRow]) {
        view?.showResults(results)
    }

    func showError(_ error: Error) {
        view?.showError(error)
    }
}
