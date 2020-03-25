//
//  CompanyModel.swift
//  News
//
//  Created by Михаил Борисов on 24.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import Foundation

struct Company: Decodable {

    let name: String

    let ticker: String

    let description: String

    var currency: String = "RUB"
}
