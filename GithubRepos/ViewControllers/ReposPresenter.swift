//
//  ReposPresenter.swift
//  GithubRepos
//
//  Created by kotl on 22.12.2020.
//

import UIKit

final class ReposPresenter: NSObject {
    
    @UserDefaultsBacked(key: "reviewedRepoIds", defaultValue: [])
    private var reviewedRepoIds: [Int]

    private var repos = [RepoDispalayable]()

    private let tableView: UITableView

    let papa: ReposSearchViewController

    init(tableView: UITableView, papa: ReposSearchViewController) {
        self.tableView = tableView

        self.papa = papa
        super.init()

        configurateViews()
    }

    private func configurateViews() {
        let nib = UINib(nibName: "RepoTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "repoCell")

        tableView.delegate = self
        tableView.dataSource = self
    }

    func reloadReposTableView(with repos: [RepoDispalayable]) {
        DispatchQueue.main.async { [weak self] in
            self?.repos = repos
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension ReposPresenter: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = repos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell",
                                                 for: indexPath) as! RepoTableViewCell
        cell.configurate(with: repo)

        if reviewedRepoIds.contains(repo.id) {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .white
        }

        return cell
    }

}


// MARK: - UITableViewDelegate
extension ReposPresenter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == repos.count - 3 {
            papa.loadNextPage()
        }
    
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .lightGray

        let repo = repos[indexPath.row]

        if !reviewedRepoIds.contains(repo.id) {
            reviewedRepoIds.append(repo.id)
        }

        guard let link = repo.link else { return }
        UIApplication.shared.open(link)
    }

}
