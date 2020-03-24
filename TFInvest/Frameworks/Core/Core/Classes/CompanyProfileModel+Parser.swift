//
//  CompanyProfileModel+Parser.swift
//  Assembly
//
//  Created by Sergey Korobin on 23.03.2020.
//

import Foundation

public struct CompanyProfileModel: Decodable {
    public let address: String
    public let city: String
    public let country: String
    public let currency: String
    public let cusip: String
    public let description: String
    public let employeeTotal: String
    public let exchange: String
    public let ggroup: String
    public let gind: String
    public let gsector: String
    public let gsubind: String
    public let ipo: String
    public let isin: String
    public let marketCapitalization: Int
    public let naics: String
    public let naicsNationalIndustry: String
    public let naicsSector: String
    public let naicsSubsector: String
    public let name: String
    public let phone: String
    public let sedol: String
    public let shareOutstanding: Double
    public let state: String
    public let ticker: String
    public let weburl: String

    enum CodingKeys: String, CodingKey {
        case address, city, country, currency, cusip, description, employeeTotal, exchange, ggroup, gind, gsector, gsubind, ipo, isin, marketCapitalization, naics, naicsNationalIndustry, naicsSector, naicsSubsector, name, phone, sedol, shareOutstanding, state, ticker, weburl
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.address = try container.decode(String.self, forKey: .address)
        self.city = try container.decode(String.self, forKey: .city)
        self.country = try container.decode(String.self, forKey: .country)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.cusip = try container.decode(String.self, forKey: .cusip)
        self.description = try container.decode(String.self, forKey: .description)
        self.employeeTotal = try container.decode(String.self, forKey: .employeeTotal)
        self.exchange = try container.decode(String.self, forKey: .exchange)
        self.ggroup = try container.decode(String.self, forKey: .ggroup)
        self.gind = try container.decode(String.self, forKey: .gind)
        self.gsector = try container.decode(String.self, forKey: .gsector)
        self.gsubind = try container.decode(String.self, forKey: .gsubind)
        self.ipo = try container.decode(String.self, forKey: .ipo)
        self.isin = try container.decode(String.self, forKey: .isin)
        self.marketCapitalization = try container.decode(Int.self, forKey: .marketCapitalization)
        self.naics = try container.decode(String.self, forKey: .naics)
        self.naicsNationalIndustry = try container.decode(String.self, forKey: .naicsNationalIndustry)
        self.naicsSector = try container.decode(String.self, forKey: .naicsSector)
        self.naicsSubsector = try container.decode(String.self, forKey: .naicsSubsector)
        self.name = try container.decode(String.self, forKey: .name)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.sedol = try container.decode(String.self, forKey: .sedol)
        self.shareOutstanding = try container.decode(Double.self, forKey: .shareOutstanding)
        self.state = try container.decode(String.self, forKey: .state)
        self.ticker = try container.decode(String.self, forKey: .ticker)
        self.weburl = try container.decode(String.self, forKey: .weburl)

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
