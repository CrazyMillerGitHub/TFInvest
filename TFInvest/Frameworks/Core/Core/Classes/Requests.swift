//
//  Requests.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 01.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation

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
