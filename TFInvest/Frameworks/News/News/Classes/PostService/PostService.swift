//
//  DataManager.swift
//  News
//
//  Created by Михаил Борисов on 23.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import Foundation
import Combine

class PostsService {

    static var shared: PostsService = PostsService()

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    func getPosts(url: URL) -> AnyPublisher<[Post], Error> {

        let req = URLRequest(url: url)

        return URLSession.DataTaskPublisher(request: req, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    fatalError()
                }
                return data
        }
        .decode(type: [Post].self, decoder: self.decoder)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

}

struct PostsResponse: Decodable {
    let results: [Post]
}

class CompanyService {

    static var shared: CompanyService = CompanyService()

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    func getCompany(url: URL) -> AnyPublisher<Company, Error> {

        let req = URLRequest(url: url)

        return URLSession.DataTaskPublisher(request: req, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    fatalError()
                }
                return data
        }
        .decode(type: Company.self, decoder: self.decoder)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

}
