//
//  NetworkService.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 01.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation
import Core

public protocol NetworkServiceProtocol {
    func loadAvailableExchanges(completionHandler: @escaping (Result<[AvailableExchangeModel], Error>) -> Void)
    func loadAvailableStocks(exchangeCode: String, completionHandler: @escaping (Result<[AvailableStockModel], Error>) -> Void)
    func loadGeneralNews(completionHandler: @escaping (Result<[NewsModel], Error>) -> Void)
    func loadCompanyNews(companySymbol: String, completionHandler: @escaping (Result<[NewsModel], Error>) -> Void)
    func loadCompanyProfile(companySymbol: String, completionHandler: @escaping (Result<CompanyProfileModel, Error>) -> Void)
}

open class NetworkService: NetworkServiceProtocol {

    private let requestSender: RequestSenderProtocol = RequestSender()

    public init() {}

    public func loadAvailableExchanges(completionHandler: @escaping (Result<[AvailableExchangeModel], Error>) -> Void) {
        let config = RequestsFactory.FinhubAPIRequests.availableExchangesConfig()
        self.requestSender.send(config: config) { (result) in
            completionHandler(result)
        }
    }

    public func loadAvailableStocks(exchangeCode: String, completionHandler: @escaping (Result<[AvailableStockModel], Error>) -> Void) {
        let config = RequestsFactory.FinhubAPIRequests.availableStocksConfig(exchangeCode: exchangeCode)
        self.requestSender.send(config: config) { (result) in
            completionHandler(result)
        }
    }

    public func loadGeneralNews(completionHandler: @escaping (Result<[NewsModel], Error>) -> Void) {
        let config = RequestsFactory.FinhubAPIRequests.generalNewsConfig()
        self.requestSender.send(config: config) { (result) in
            completionHandler(result)
        }
    }

    public func loadCompanyNews(companySymbol: String, completionHandler: @escaping (Result<[NewsModel], Error>) -> Void) {
        let config = RequestsFactory.FinhubAPIRequests.companyNewsConfig(companySymbol: companySymbol)
        self.requestSender.send(config: config) { (result) in
           completionHandler(result)
        }
    }

    public func loadCompanyProfile(companySymbol: String, completionHandler: @escaping (Result<CompanyProfileModel, Error>) -> Void) {
        let config = RequestsFactory.FinhubAPIRequests.companyProfileConfig(companySymbol: companySymbol)
        self.requestSender.send(config: config) { (result) in
           completionHandler(result)
        }
    }

}
