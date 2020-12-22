//
//  ViewController.swift
//  GithubReposMVVM
//
//  Created by kotl on 21.12.2020.
//

import UIKit

class ReposSearchViewController: UIViewController {

    private var repos = [RepoViewModel]() {
        didSet {
            presenter.reloadReposTableView(with: repos)
        }
    }

    private let networkService: NetworkServiceProvidable = NetworkService()
    private var presenter: ReposPresenter!

    @UserDefaultsBacked(key: "reviewedRepoIds", defaultValue: [])
    private var reviewedRepoIds: [Int]

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
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
//            print(response)
            guard let repos = response else { return }
            self.repos = repos.items.map { RepoViewModel(with: $0) }
        }
    }

    @IBAction func searchTapped() {
        guard let text = searchBar.text,
              !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        searchRepos(query: text)
    }

}

extension ReposSearchViewController: ReposPresenterDelegate {

    func repoCellTapped(_ repo: RepoViewModel) {

    }
    
}
