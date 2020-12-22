//
//  Owner.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import Foundation

/// Github Repo owner decodable model
struct Owner: Decodable {

    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url, received_events_url: String
    let type: String
    let html_url, followers_url: String
    let following_url, gists_url, starred_url: String
    let subscriptions_url, organizations_url, repos_url: String
    let events_url: String
    let site_admin: Bool

}
