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

class StockNewsViewModel: ObservableObject {

    let networkService = NetworkService()

    let commapyIDX: String

    @Published var posts: [NewsModel]

    @Published var company = CompanyProfileModel(address: "", city: "", country: "", currency: "", cusip: "", description: "", employeeTotal: "", exchange: "", ggroup: "", gind: "", gsector: "", gsubind: "", ipo: "", isin: "", marketCapitalization: 0, naics: "", naicsNationalIndustry: "", naicsSector: "", naicsSubsector: "", name: "", phone: "", sedol: "", shareOutstanding: 0, state: "", ticker: "", weburl: "")

    var task: AnyCancellable?

    init(commapyIDX: String, posts: [NewsModel] = []) {
        self.commapyIDX = commapyIDX
        self.posts = posts
    }

}

extension StockNewsViewModel: StockNewsViewModelProtocol {

    func stockInfo() {

        networkService.loadCompanyProfile(companySymbol: "AAPL") { (result) in
            switch result {
            case .success(let company):
                self.company = company
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchPosts() {

        networkService.loadCompanyNews(companySymbol: "AAPL") { (result) in
            switch result {
            case .success(let posts):
                self.posts = posts
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
