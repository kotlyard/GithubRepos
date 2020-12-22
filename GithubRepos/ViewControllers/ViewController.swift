//
//  ViewController.swift
//  GithubReposMVVM
//
//  Created by kotl on 21.12.2020.
//

import UIKit

class ViewController: UIViewController {

    private var repos = [RepoViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private let networkService: NetworkServiceProvidable = NetworkService()

//    @UserDefaultsBacked(key: "reviewedRepoIds", defaultValue: [])
//    private var reviewedRepoIds

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "RepoTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "repoCell")
        
        var request = GetReposRequest()
        request.q = "sas"
        networkService.getRepos(request: request) { (response, error) in
            print(response)
            guard let repos = response else { return }
            self.repos = repos.items.map { RepoViewModel(with: $0) }
        }
    }


}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

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
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
