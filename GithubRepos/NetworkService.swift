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

        urlComponents.query = formQuery(from: request.dictionary)
        print(urlComponents.url!)
        guard let url = urlComponents.url else { return completion(nil, nil) }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return completion(nil, error) }
            do {
//                print(String(data: data, encoding: .utf8))
                let decoded = try JSONDecoder().decode(GetReposResponse.self, from: data)
                completion(decoded, nil)
            }
            catch {
                print(error)
                completion(nil, error)
            }
        }

        task.resume()
    }

    private func formQuery(from dictionary: [String: Any]?) -> String? {
        dictionary?.compactMap { (key, value) -> String in
            "\(key)=\(value)"
        }.joined(separator: "&")
    }
}
