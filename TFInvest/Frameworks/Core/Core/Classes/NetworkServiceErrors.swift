//
//  NetworkErrors.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 01.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation

public enum NetworkServiceError: Error {
    case urlConstuctFailure(String)
    case decodeError(String)
}
