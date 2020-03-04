//
//  NetworkProtocols.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 01.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation

public protocol ParserProtocol {
    associatedtype Model
    func parse(data: Data) -> Model?
}

public protocol RequestProtocol {
    var urlRequest: URLRequest? {get set}
}
