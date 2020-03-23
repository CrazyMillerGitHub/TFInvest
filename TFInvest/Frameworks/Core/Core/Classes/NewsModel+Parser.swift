//
//  NewsModel+Parser.swift
//  Assembly
//
//  Created by Sergey Korobin on 23.03.2020.
//

import Foundation

public struct NewsModel: Decodable {
    public let category: String
    public let datetime: Int
    public let id: Int
    public let image: String
    public let related: String?
    public let source: String?
    public let summary: String?
    public let url: String

    enum CodingKeys: String, CodingKey {
        case category, datetime, id, image, related, source, summary, url
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.category = try container.decode(String.self, forKey: .category)
        self.datetime = try container.decode(Int.self, forKey: .datetime)
        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.related = try container.decode(String.self, forKey: .related)
        self.source = try container.decode(String.self, forKey: .source)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

public class NewsParser: ParserProtocol {
    public typealias Model = [NewsModel]

    public func parse(data: Data) -> [NewsModel]? {
        guard let parsedResponseData = try? JSONDecoder().decode([NewsModel].self, from: data) else {
            // print("\nError: can't parse response of AvailableStocks request.\n")

            return nil
        }
        return parsedResponseData
    }
}
