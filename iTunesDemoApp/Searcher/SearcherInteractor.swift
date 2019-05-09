//
//  SearcherInteractor.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/8/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

protocol SearcherInteractorProtocol: Interactor {
    func getResults(value: String)
}

protocol SearcherInteractorDelegate: class {
    func showResults(_ results: [ResultRow])
    func showError(_ error: Error)
}

class SearcherInteractor: SearcherInteractorProtocol {
    let repository: SearcherRepositoryProtocol
    weak var delegate: SearcherInteractorDelegate?

    init(repository: SearcherRepositoryProtocol) {
        self.repository = repository
    }

    func getResults(value: String) {
        repository.getResults(value: value) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let results):
                strongSelf.delegate?.showResults(results.results.filter { $0.kind == "song" } )
            case .failure(let error):
                strongSelf.delegate?.showError(error)
            }
        }
    }
}
