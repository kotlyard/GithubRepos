//
//  ViewController.swift
//  GithubReposMVVM
//
//  Created by kotl on 21.12.2020.
//

import UIKit

class ReposSearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!


    // MARK: - Variables
    private var getReposResponse: GetReposResponse? {
        didSet {
            let repos = getReposResponse?.items.compactMap { RepoViewModel(with: $0) } ?? []
            guard !repos.isEmpty else { return }

            presenter.reloadReposTableView(with: repos)
        }
    }

    private let networkService: NetworkServiceProvidable = NetworkService()
    private var presenter: ReposPresenter!
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = ReposPresenter(tableView: tableView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
    }

    private func searchRepos(query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        var request = GetReposRequest()
        request.q = query

        networkService.getRepos(request: request) { (response, error) in
            self.getReposResponse = response
        }
    }

    // MARK: - Actions
    @IBAction private func searchTapped() {
        guard let text = searchBar.text else { return }

        searchRepos(query: text)
    }

}
