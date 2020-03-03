//
//  RequestsSender.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 01.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation
import Base

public protocol RequestSenderProtocol {
    func send<Model, Parser>(config: RequestConfig<Model, Parser>, completionHandler: @escaping (Result<Model, Error>) -> Void )
}

public class RequestSender: RequestSenderProtocol {

    public init() {}

    public func send<ModelType, Parser>(config: RequestConfig<ModelType, Parser>, completionHandler: @escaping (Result<ModelType, Error>) -> Void) {

        let inQueue = DispatchQueue.current

        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(NetworkServiceError.urlConstuctFailure("URL string can't be parsed to URL.")))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let data = data, let parsedModel = config.parser.parse(data: data) else {
                completionHandler(.failure(NetworkServiceError.decodeError("Received data can not be parsed.")))
                return
            }

            inQueue?.async {
                completionHandler(Result.success(parsedModel))
            }
        }

        task.resume()
    }
}
