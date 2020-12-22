//
//  ReposPresenter.swift
//  GithubRepos
//
//  Created by kotl on 22.12.2020.
//

import UIKit


protocol ReposPresenterDelegate: class {

    func repoCellTapped(_ repo: RepoViewModel)

}

final class ReposPresenter: NSObject {
    
    weak var delegate: ReposPresenterDelegate?
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoTableViewCell
        cell.configurate(with: repos[indexPath.row])
        return cell
    }
    
    
}


// MARK: - UITableViewDelegate
extension ReposPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let repo = repos[indexPath.row]
        delegate?.repoCellTapped(repo)
    }

}
