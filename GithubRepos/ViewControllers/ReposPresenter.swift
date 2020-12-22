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

    private var repos = [RepoViewModel]()

    private let tableView: UITableView


    init(tableView: UITableView) {
        self.tableView = tableView

        super.init()

        configurateViews()
    }

    private func configurateViews() {
        let nib = UINib(nibName: "RepoTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "repoCell")

        tableView.delegate = self
        tableView.dataSource = self
    }

    func reloadReposTableView(with repos: [RepoViewModel]) {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .lightGray

        let repoId = repos[indexPath.row].id

        if !reviewedRepoIds.contains(repoId) {
            reviewedRepoIds.append(repoId)
        }
    }

}
