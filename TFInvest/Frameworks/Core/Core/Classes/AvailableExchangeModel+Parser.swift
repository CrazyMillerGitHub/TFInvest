//
//  AvailableExchangesModel+Parser.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 02.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation

public struct AvailableExchangeModel: Decodable {

    public let code: String
    public let currency: String
    public let name: String

    enum CodingKeys: String, CodingKey {
        case code, currency, name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

public class AvailableExchangesParser: ParserProtocol {
    public typealias Model = [AvailableExchangeModel]

    public func parse(data: Data) -> [AvailableExchangeModel]? {
        guard let parsedResponseData = try? JSONDecoder().decode([AvailableExchangeModel].self, from: data) else {
            // print("\nError: can't parse response of AvailableExchanges request.\n")

            return nil
        }
        return parsedResponseData
    }
}
