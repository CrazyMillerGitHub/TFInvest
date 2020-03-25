//
//  SockNewsViewModel.swift
//  News
//
//  Created by Михаил Борисов on 24.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import Combine
import Services
import Core

protocol StockNewsViewModelProtocol {

    var posts: [NewsModel] { get }

    func fetchPosts()

    func stockInfo()
}

final class StockNewsViewModel: ObservableObject {

    let networkService = NetworkService()

    let companyIDX: String

    @Published var posts: [NewsModel]

    @Published var company = CompanyProfileModel()

    var task: AnyCancellable?

    init(companyIDX: String, posts: [NewsModel] = []) {
        self.companyIDX = companyIDX
        self.posts = posts
    }

}

extension StockNewsViewModel: StockNewsViewModelProtocol {

    func stockInfo() {

        networkService.loadCompanyProfile(companySymbol: companyIDX) { (result) in

            switch result {
            case .success(let company):
                self.company = company
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchPosts() {

        networkService.loadCompanyNews(companySymbol: companyIDX) { (result) in

            switch result {
            case .success(let posts):
                self.posts = posts
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
