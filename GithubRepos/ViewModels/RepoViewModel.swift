//
//  RepoViewModel.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import UIKit

struct RepoViewModel {

    let id: Int
    let name: String
    let ownerLogin: String
    let starsCount: Int

    init(with repo: Repo) {
        id = repo.id
        name = repo.name
        ownerLogin = repo.owner.login
        starsCount = repo.stargazers_count
    }

}

