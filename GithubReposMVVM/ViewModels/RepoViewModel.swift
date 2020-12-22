//
//  RepoViewModel.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import UIKit

struct RepoViewModel {

    let name: String
    let ownerLogin: String
    let starsCount: Int

    init(with repo: Repo) {
        name = repo.fullName
        ownerLogin = repo.owner.login
        starsCount = repo.stargazersCount
    }

}
