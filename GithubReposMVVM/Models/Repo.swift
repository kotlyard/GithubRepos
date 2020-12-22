//
//  Repo.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import Foundation


// MARK: - Item
struct Repo: Decodable {

    let id: Int
    let nodeid, name, fullName: String
    let owner: Owner
    let itemPrivate: Bool
    let htmlurl: String
    let itemDescription: String
    let fork: Bool
    let url: String
    let createdAt, updatedAt, pushedAt: Date
    let homepage: String
    let size, stargazersCount, watchersCount: Int
    let language: String
    let forksCount, openIssuesCount: Int
    let masterBranch, defaultBranch: String
    let score: Int
    let archiveurl, assigneesurl, blobsurl, branchesurl: String
    let collaboratorsurl, commentsurl, commitsurl, compareurl: String
    let contentsurl: String
    let contributorsurl, deploymentsurl, downloadsurl, eventsurl: String
    let forksurl: String
    let gitCommitsurl, gitRefsurl, gitTagsurl, giturl: String
    let issueCommenturl, issueEventsurl, issuesurl, keysurl: String
    let labelsurl: String
    let languagesurl, mergesurl: String
    let milestonesurl, notificationsurl, pullsurl, releasesurl: String
    let sshurl: String
    let stargazersurl: String
    let statusesurl: String
    let subscribersurl, subscriptionurl, tagsurl, teamsurl: String
    let treesurl: String
    let cloneurl: String
    let mirrorurl: String
    let hooksurl, svnurl: String
    let forks, openIssues, watchers: Int
    let hasIssues, hasProjects, hasPages, hasWiki: Bool
    let hasDownloads, archived, disabled: Bool
    let license: License

}

// MARK: - License
struct License: Decodable {

    let key, name: String
    let url: String
    let spdxid, nodeid: String
    let htmlurl: String

}

// MARK: - Owner
struct Owner: Decodable {

    let login: String
    let id: Int
    let nodeid: String
    let avatarurl: String
    let gravatarid: String
    let url, receivedEventsurl: String
    let type: String
    let htmlurl, followersurl: String
    let followingurl, gistsurl, starredurl: String
    let subscriptionsurl, organizationsurl, reposurl: String
    let eventsurl: String
    let siteAdmin: Bool

}
