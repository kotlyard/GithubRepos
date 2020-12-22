//
//  ViewController.swift
//  GithubReposMVVM
//
//  Created by kotl on 21.12.2020.
//

import UIKit

class ViewController: UIViewController {

    private var repos = [RepoViewModel]()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RepoTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "repoCell")
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
