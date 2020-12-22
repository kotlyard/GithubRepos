//
//  RepoDispalayable.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import UIKit

struct RepoDispalayable {

    let id: Int
    let name: String
    let ownerLogin: String
    let starsCount: Int
    let link: URL?

    init(with repo: Repo) {
        id = repo.id
        name = repo.name
        ownerLogin = repo.owner.login
        starsCount = repo.stargazers_count
        link = URL(string: repo.html_url)
    }

}

