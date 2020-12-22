//
//  NetworkService.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import Foundation

protocol NetworkServiceProvidable {

    func getRepos(request: GetReposRequest, _ completion: @escaping (GetReposResponse?, Error?) -> Void)

}

final class NetworkService: NetworkServiceProvidable {

    private let getReposUrlString = "https://api.github.com/search/repositories"

    func getRepos(request: GetReposRequest, _ completion: @escaping (GetReposResponse?, Error?) -> Void) {
        guard var urlComponents = URLComponents(string: getReposUrlString) else { return completion(nil, nil) }

        let params = request.dictionary

        urlComponents.query = params?.compactMap { (key, value) -> String in
            "\(key)=\(value)"
        }.joined(separator: "&")
    
        print(urlComponents.string)
        guard let url = urlComponents.url else { return completion(nil, nil) }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return completion(nil, error) }
            do {
                let decoded = try JSONDecoder().decode(GetReposResponse.self, from: data)
                completion(decoded, nil)
            }
            catch {
                print(error)
            }
        }

        task.resume()
    }

}
