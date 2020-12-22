//
//  GetReposRequest.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import Foundation

struct GetReposRequest: Encodable {
    
    var accept: String? = "application/vnd.github.mercy-preview+json"
    var q: String?
    var sort: String? = "stars"
    var order: String? = "desc"
    var per_page: Int? = 30
    var page: Int?

}

