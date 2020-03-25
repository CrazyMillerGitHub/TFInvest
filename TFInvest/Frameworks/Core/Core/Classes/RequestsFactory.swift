//
//  RequestsFactory.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 01.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation

public struct RequestConfig<Model, Parser: ParserProtocol> where Parser.Model == Model {
    public let request: RequestProtocol
    public let parser: Parser
}

public class RequestsFactory {

    public struct FinhubAPIRequests {
        
        private static let TOKEN = "bpdq8nfrh5rauiikjq80"

        public static func availableExchangesConfig() -> RequestConfig<[AvailableExchangeModel], AvailableExchangesParser> {
            return RequestConfig(request: AvailableExchangesRequest(apiToken: TOKEN), parser: AvailableExchangesParser())
        }

        public static func availableStocksConfig(exchangeCode: String) -> RequestConfig<[AvailableStockModel], AvailableStocksParser> {
            return RequestConfig(request: AvailableStocksRequest(exchangeCode: exchangeCode, apiToken: TOKEN), parser: AvailableStocksParser())
        }

        public static func generalNewsConfig() -> RequestConfig<[NewsModel], NewsParser> {
            return RequestConfig(request: GeneralNewsRequest(apiToken: TOKEN), parser: NewsParser())
        }

        public static func companyNewsConfig(companySymbol: String) -> RequestConfig<[NewsModel], NewsParser> {
            return RequestConfig(request: CompanyNewsRequest(companySymbol: companySymbol, apiToken: TOKEN), parser: NewsParser())
        }

        public static func companyProfileConfig(companySymbol: String) -> RequestConfig<CompanyProfileModel, CompanyProfileParser> {
            return RequestConfig(request: CompanyProfileRequest(companySymbol: companySymbol, apiToken: TOKEN), parser: CompanyProfileParser())
        }
    }
}
