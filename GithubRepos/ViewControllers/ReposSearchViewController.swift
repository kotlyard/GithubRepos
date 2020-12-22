//
//  ViewController.swift
//  GithubReposMVVM
//
//  Created by kotl on 21.12.2020.
//

import UIKit

final class ReposSearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!


    // MARK: - Variables
    private let networkService: NetworkServiceProvidable = NetworkService()
    private var presenter: ReposPresenter!
    private var lastSearchRequest: GetReposRequest?

    private var getReposResponse: GetReposResponse? {
        didSet {
            let repos = getReposResponse?
                .items
                .compactMap { RepoDispalayable(with: $0) } ?? []
            presenter.reloadReposTableView(with: repos)
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = ReposPresenter(tableView: tableView)
        presenter.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        searchBar.becomeFirstResponder()
    }

    private func searchRepos(query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        var request = GetReposRequest()
        request.q = query

        networkService.getRepos(request: request) { [weak self] (response, error) in
            self?.getReposResponse = response
        }
        lastSearchRequest = request
    }

    // MARK: - Actions
    @IBAction private func searchTapped() {
        guard let text = searchBar.text else { return }

        searchRepos(query: text)
    }

}

// MARK: - ReposPresenterDelegate
extension ReposSearchViewController: ReposPresenterDelegate {

    func loadNextPage() {
        guard var request = lastSearchRequest else { return }
        guard let response = getReposResponse,
              response.total_count > response.items.count * request.per_page else { return }

        request.page += 1

        networkService.getRepos(request: request) { [weak self] (response, error) in
            guard let repos = response?.items else { return }
            self?.getReposResponse?.items.append(contentsOf: repos)
        }

        lastSearchRequest = request
    }

}
