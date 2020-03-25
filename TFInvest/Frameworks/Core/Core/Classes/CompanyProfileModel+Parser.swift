//
//  CompanyProfileModel+Parser.swift
//  Assembly
//
//  Created by Sergey Korobin on 23.03.2020.
//

import Foundation

public struct CompanyProfileModel {

    public let address: String?
    public let city: String?
    public let country: String?
    public let currency: String?
    public let cusip: String?
    public let newsDescription: String?
    public let employeeTotal: String?
    public let exchange: String?
    public let ggroup: String?
    public let gind: String?
    public let gsector: String?
    public let gsubind: String?
    public let ipo: String?
    public let isin: String?
    public let marketCapitalization: Double?
    public let naics: String?
    public let naicsNationalIndustry: String?
    public let naicsSector: String?
    public let naicsSubsector: String?
    public let name: String?
    public let phone: String?
    public let sedol: String?
    public let shareOutstanding: Double?
    public let state: String?
    public let ticker: String?
    public let weburl: String?

    public init(address: String? = nil, city: String? = nil, country: String? = nil, currency: String? = nil, cusip: String? = nil, newsDescription: String? = nil, employeeTotal: String? = nil, exchange: String? = nil, ggroup: String? = nil, gind: String? = nil, gsector: String? = nil, gsubind: String? = nil, ipo: String? = nil, isin: String? = nil, marketCapitalization: Double? = nil, naics: String? = nil, naicsNationalIndustry: String? = nil, naicsSector: String? = nil, naicsSubsector: String? = nil, name: String? = nil, phone: String? = nil, sedol: String? = nil, shareOutstanding: Double? = nil, state: String? = nil, ticker: String? = nil, weburl: String? = nil) {
        self.address = address
        self.city = city
        self.country = country
        self.currency = currency
        self.cusip = cusip
        self.newsDescription = newsDescription
        self.employeeTotal = employeeTotal
        self.exchange = exchange
        self.ggroup = ggroup
        self.gind = gind
        self.gsector = gsector
        self.gsubind = gsubind
        self.ipo = ipo
        self.isin = isin
        self.marketCapitalization = marketCapitalization
        self.naics = naics
        self.naicsNationalIndustry = naicsNationalIndustry
        self.naicsSector = naicsSector
        self.naicsSubsector = naicsSubsector
        self.name = name
        self.phone = phone
        self.sedol = sedol
        self.shareOutstanding = shareOutstanding
        self.state = state
        self.ticker = ticker
        self.weburl = weburl
    }

}

extension CompanyProfileModel: Decodable {

    public enum CodingKeys: String, CodingKey {
        case address, city, country, currency, cusip
        case newsDescription = "description"
        case employeeTotal, exchange, ggroup, gind, gsector, gsubind, ipo, isin, marketCapitalization, naics, naicsNationalIndustry, naicsSector, naicsSubsector, name, phone, sedol, shareOutstanding, state, ticker, weburl
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let address = try container.decode(String.self, forKey: .address)
        let city = try container.decode(String.self, forKey: .city)
        let country = try container.decode(String.self, forKey: .country)
        let currency = try container.decode(String.self, forKey: .currency)
        let cusip = try container.decode(String.self, forKey: .cusip)
        let newsDescription = try container.decode(String.self, forKey: .newsDescription)
        let employeeTotal = try container.decode(String.self, forKey: .employeeTotal)
        let exchange = try container.decode(String.self, forKey: .exchange)
        let ggroup = try container.decode(String.self, forKey: .ggroup)
        let gind = try container.decode(String.self, forKey: .gind)
        let gsector = try container.decode(String.self, forKey: .gsector)
        let gsubind = try container.decode(String.self, forKey: .gsubind)
        let ipo = try container.decode(String.self, forKey: .ipo)
        let isin = try container.decode(String.self, forKey: .isin)
        let marketCapitalization = try container.decode(Double.self, forKey: .marketCapitalization)
        let naics = try container.decode(String.self, forKey: .naics)
        let naicsNationalIndustry = try container.decode(String.self, forKey: .naicsNationalIndustry)
        let naicsSector = try container.decode(String.self, forKey: .naicsSector)
        let naicsSubsector = try container.decode(String.self, forKey: .naicsSubsector)
        let name = try container.decode(String.self, forKey: .name)
        let phone = try container.decode(String.self, forKey: .phone)
        let sedol = try container.decode(String.self, forKey: .sedol)
        let shareOutstanding = try container.decode(Double.self, forKey: .shareOutstanding)
        let state = try container.decode(String.self, forKey: .state)
        let ticker = try container.decode(String.self, forKey: .ticker)
        let weburl = try container.decode(String.self, forKey: .weburl)

        self.init(address: address, city: city, country: country, currency: currency, cusip: cusip, newsDescription: newsDescription, employeeTotal: employeeTotal, exchange: exchange, ggroup: ggroup, gind: gind, gsector: gsector, gsubind: gsubind, ipo: ipo, isin: isin, marketCapitalization: marketCapitalization, naics: naics, naicsNationalIndustry: naicsNationalIndustry, naicsSector: naicsSector, naicsSubsector: naicsSubsector, name: name, phone: phone, sedol: sedol, shareOutstanding: shareOutstanding, state: state, ticker: ticker, weburl: weburl)
    }
}

public class CompanyProfileParser: ParserProtocol {
    public typealias Model = CompanyProfileModel

    public func parse(data: Data) -> CompanyProfileModel? {
        guard let parsedResponseData = try? JSONDecoder().decode(CompanyProfileModel.self, from: data) else {
            // print("\nError: can't parse response of AvailableStocks request.\n")

            return nil
        }
        return parsedResponseData
    }
}
