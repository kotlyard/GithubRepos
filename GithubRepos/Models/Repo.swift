//
//  Repo.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import Foundation


/// Github Repo  decodable model
struct Repo: Decodable {

    let id: Int
    let node_id, name, full_name: String
    let owner: Owner
    let html_url: String
    let fork: Bool
    let url: String
    let homepage: String?
    let size, stargazers_count, watchers_count: Int
    let language: String?
    let forks_count, open_issues_count: Int
    let default_branch: String
    let score: Int
    let forks, open_issues, watchers: Int
    let has_issues, has_projects, has_pages, has_wiki: Bool
    let has_downloads, archived, disabled: Bool

}
