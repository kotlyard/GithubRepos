//
//  GetReposResponse.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import Foundation

// MARK: - GetReviewsResponse
struct GetReposResponse: Decodable {

    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repo]

}
