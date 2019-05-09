//
//  SearcherViewController.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/8/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import UIKit
import AVFoundation

class SearcherViewController: UIViewController {
    let presenter: SearcherPresenterProtocol?
    let searchController = UISearchController(searchResultsController: nil)
    var player = AVAudioPlayer()
    var results = [ResultRow]()

    @IBOutlet var tableView: UITableView?

    init(presenter: SearcherPresenterProtocol?) {
        self.presenter = presenter
        super.init(nibName: SearcherViewController.nameOfClass, bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        self.presenter = nil
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchController()
        tableView?.register(ResultTableViewCell.nib, forCellReuseIdentifier: ResultTableViewCell.reusableIdentifier)
    }

    func initSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Artists"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

// MARK: - SearcherView
extension SearcherViewController: SearcherView {
    func showResults(_ results: [ResultRow]) {
        self.results = results
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView?.reloadData()
        }
    }

    func showError(_ error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - UITableView DataSource
extension SearcherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reusableIdentifier, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
        cell.result = results[indexPath.row]
        return cell
    }
}

// MARK: - UITableView Delegate
extension SearcherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let previewUrl = results[indexPath.row].previewUrl {
            AudioUtils.play(from: previewUrl) { [weak self] url in
                guard let strongSelf = self else { return }
                do {
                    strongSelf.player = try AVAudioPlayer(contentsOf: url)
                    strongSelf.player.prepareToPlay()
                    strongSelf.player.play()
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearcherViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        results = []
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView?.reloadData()
        }
        if let text = searchController.searchBar.text {
            presenter?.getResults(value: text)
        }
    }
}
