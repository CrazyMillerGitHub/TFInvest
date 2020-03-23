//
//  PostModel.swift
//  News
//
//  Created by Михаил Борисов on 23.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import Foundation

public struct Post: Identifiable, Codable {

    public let id: Int

    let headline: String

    let summary: String

    let image: String

    let datetime: Int

    let url: String

    var webURL: URL {
        return URL(string: url)!
    }

}
