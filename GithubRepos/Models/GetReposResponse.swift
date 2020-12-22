//
//  GetReposResponse.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import Foundation

struct GetReposResponse: Decodable {

    let total_count: Int
    let incomplete_results: Bool
    let items: [Repo]

}
