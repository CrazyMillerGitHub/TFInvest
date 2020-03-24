//
//  Requests.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 01.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation

// MARK: Exchanges&Stocks requests

class AvailableExchangesRequest: RequestProtocol {

    var urlRequest: URLRequest?
    fileprivate let urlString = "https://finnhub.io/api/v1/stock/exchange"

    init(apiToken: String) {

        guard var urlComponents = URLComponents(string: urlString) else {
            // не вижу кейс, что здесь может быть ошибка, но я обернул
            return
        }

        var urlQueryItems = [URLQueryItem]()
        let tokenQueryItem = URLQueryItem(name: "token", value: apiToken)

        urlQueryItems.append(tokenQueryItem)
        urlComponents.queryItems = urlQueryItems

        guard let url = urlComponents.url else {
            // Ошибка, не смог собрать конечную URL с присоединением новых компонентов
            return
        }
        urlRequest = URLRequest(url: url)
        urlRequest?.httpMethod = "GET"
    }
}

class AvailableStocksRequest: RequestProtocol {

    var urlRequest: URLRequest?
    fileprivate let urlString = "https://finnhub.io/api/v1/stock/symbol"

    init(exchangeCode: String, apiToken: String) {

        guard var urlComponents = URLComponents(string: urlString) else {
            return
        }

        var urlQueryItems = [URLQueryItem]()
        let exchangeCodeQueryItem = URLQueryItem(name: "exchange", value: exchangeCode)
        let tokenQueryItem = URLQueryItem(name: "token", value: apiToken)

        urlQueryItems.append(contentsOf: [exchangeCodeQueryItem, tokenQueryItem])
        urlComponents.queryItems = urlQueryItems

        guard let url = urlComponents.url else {
            // Ошибка, не смог собрать конечную URL с присоединением новых компонентов
            return
        }
        urlRequest = URLRequest(url: url)
        urlRequest?.httpMethod = "GET"
    }
}

// MARK: News requests

class GeneralNewsRequest: RequestProtocol {

    var urlRequest: URLRequest?
    fileprivate let urlString = "https://finnhub.io/api/v1/news"

    init(apiToken: String) {

        guard var urlComponents = URLComponents(string: urlString) else {
            return
        }

        var urlQueryItems = [URLQueryItem]()
        let categoryQueryItem = URLQueryItem(name: "category", value: "general")
        let tokenQueryItem = URLQueryItem(name: "token", value: apiToken)

        urlQueryItems.append(contentsOf: [categoryQueryItem, tokenQueryItem])
        urlComponents.queryItems = urlQueryItems

        guard let url = urlComponents.url else {
            // Ошибка, не смог собрать конечную URL с присоединением новых компонентов
            return
        }
        urlRequest = URLRequest(url: url)
        urlRequest?.httpMethod = "GET"
    }
}

class CompanyNewsRequest: RequestProtocol {

    var urlRequest: URLRequest?
    fileprivate let urlString = "https://finnhub.io/api/v1/news/"

    init(companySymbol: String, apiToken: String) {
        let fullUrlString = urlString + companySymbol
        guard var urlComponents = URLComponents(string: fullUrlString) else {
            return
        }

        var urlQueryItems = [URLQueryItem]()
        let tokenQueryItem = URLQueryItem(name: "token", value: apiToken)

        urlQueryItems.append(tokenQueryItem)
        urlComponents.queryItems = urlQueryItems

        guard let url = urlComponents.url else {
            // Ошибка, не смог собрать конечную URL с присоединением новых компонентов
            return
        }
        urlRequest = URLRequest(url: url)
        urlRequest?.httpMethod = "GET"
    }
}

// MARK: Company Profile requests

class CompanyProfileRequest: RequestProtocol {

    var urlRequest: URLRequest?
    fileprivate let urlString = "https://finnhub.io/api/v1/stock/profile"

    init(companySymbol: String, apiToken: String) {
        guard var urlComponents = URLComponents(string: urlString) else {
            return
        }

        var urlQueryItems = [URLQueryItem]()
        let companySymbolQueryItem = URLQueryItem(name: "symbol", value: companySymbol)
        let tokenQueryItem = URLQueryItem(name: "token", value: apiToken)

        urlQueryItems.append(contentsOf: [companySymbolQueryItem, tokenQueryItem])
        urlComponents.queryItems = urlQueryItems

        guard let url = urlComponents.url else {
            // Ошибка, не смог собрать конечную URL с присоединением новых компонентов
            return
        }
        urlRequest = URLRequest(url: url)
        urlRequest?.httpMethod = "GET"
    }
}
