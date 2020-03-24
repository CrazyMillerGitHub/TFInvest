//
//  SockNewsViewModel.swift
//  News
//
//  Created by Михаил Борисов on 24.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import Combine

protocol StockNewsViewModelProtocol {

    var posts: [Post] { get }

    func fetchPosts()

    func stockInfo()
}

class StockNewsViewModel: ObservableObject {

    let commapyIDX: String

    @Published var posts = [Post]()

    @Published var company = Company(name: "", ticker: "", description: "")

    var task: AnyCancellable?

    let postsAPI: String

    let infoAPI: String

    let token = "&token=bpdq8nfrh5rauiikjq80"

    init(commapyIDX: String) {
        self.commapyIDX = commapyIDX
        self.infoAPI = "https://finnhub.io/api/v1/stock/profile?symbol=\(commapyIDX)"
        self.postsAPI = "​https://finnhub.io/api/v1/news/\(commapyIDX)"
        fetchPosts()
    }

}

extension StockNewsViewModel: StockNewsViewModelProtocol {

    func stockInfo() {

        self.task = nil

        self.company = Company(name: "", ticker: "", description: "")

        guard let url = URL(string: "https://finnhub.io/api/v1/stock/profile?symbol=\(commapyIDX)&token=bpdq8nfrh5rauiikjq80") else {
            return

        }

        self.task = CompanyService.shared.getCompany(url: url).sink(receiveCompletion: { (completion) in
            print(completion)
        }, receiveValue: { company in

            self.company = company
        })
    }

    func fetchPosts() {

        self.task = nil

        self.posts = []

        guard let url = URL(string: postsAPI + token) else { return }

        self.task = PostsService.shared.getPosts(url: url).sink(receiveCompletion: { completion in
            print(completion)

        }, receiveValue: { posts in

            self.posts = []

        })
    }
}
