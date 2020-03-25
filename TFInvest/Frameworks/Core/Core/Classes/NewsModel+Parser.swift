//
//  NewsModel+Parser.swift
//  Assembly
//
//  Created by Sergey Korobin on 23.03.2020.
//

import Foundation

import Foundation

public struct NewsModel: Identifiable {
    public let category: String
    public let datetime: Int
    public let id: Int
    public let image: String
    public let related: String?
    public let source: String?
    public let summary: String?
    public let url: String

    public init(category: String, datetime: Int, id: Int, image: String, related: String?, source: String?, summary: String?, url: String) {
        self.category = category
        self.datetime = datetime
        self.id = id
        self.image = image
        self.related = related
        self.source = source
        self.summary = summary
        self.url = url
    }
}

extension NewsModel: Decodable {

    enum CodingKeys: String, CodingKey {
        case category, datetime, id, image, related, source, summary, url
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let category = try container.decode(String.self, forKey: .category)
        let datetime = try container.decode(Int.self, forKey: .datetime)
        let id = try container.decode(Int.self, forKey: .id)
        let image = try container.decode(String.self, forKey: .image)
        let related = try container.decode(String.self, forKey: .related)
        let source = try container.decode(String.self, forKey: .source)
        let summary = try container.decode(String.self, forKey: .summary)
        let url = try container.decode(String.self, forKey: .url)

        self.init(category: category, datetime: datetime, id: id, image: image, related: related, source: source, summary: summary, url: url)
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
