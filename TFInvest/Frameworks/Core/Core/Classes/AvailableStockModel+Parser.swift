//
//  AvailableStocksModel+Parser.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 02.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation

public struct AvailableStockModel: Decodable {
    public let description: String
    public let displaySymbol: String
    public let symbol: String

    enum CodingKeys: String, CodingKey {
        case description, displaySymbol, symbol
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decode(String.self, forKey: .description)
        self.displaySymbol = try container.decode(String.self, forKey: .displaySymbol)
        self.symbol = try container.decode(String.self, forKey: .symbol)
    }
}

public class AvailableStocksParser: ParserProtocol {
    public typealias Model = [AvailableStockModel]

    public func parse(data: Data) -> [AvailableStockModel]? {
        guard let parsedResponseData = try? JSONDecoder().decode([AvailableStockModel].self, from: data) else {
            // print("\nError: can't parse response of AvailableStocks request.\n")

            return nil
        }
        return parsedResponseData
    }
}
