//
//  ViewModel.swift
//  News
//
//  Created by Михаил Борисов on 19.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import Combine

protocol PostsViewModelProtocol {

    var posts: [Post] { get }

    func fetchNewPosts()

}

final class PostsViewModel: ObservableObject {

    @Published var posts = [Post]()

    var task: AnyCancellable?

    let postsAPI = "https://finnhub.io/api/v1/news?category=general&token="

    let token = "bpdq8nfrh5rauiikjq80"

}

extension PostsViewModel: PostsViewModelProtocol {

    func fetchNewPosts() {

        self.task = nil

        self.posts = []

        guard let url = URL(string: postsAPI + token) else { return }

        self.task = PostsService.shared.getPosts(url: url).sink(receiveCompletion: { completion in
            print(completion)

        }, receiveValue: { posts in

            self.posts = posts

        })
    }

}
