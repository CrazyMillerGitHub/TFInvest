//
//  RequestsSender.swift
//  TFInvest-NetworkService
//
//  Created by Sergey Korobin on 01.03.2020.
//  Copyright © 2020 Sergey Korobin. All rights reserved.
//

import Foundation

public protocol RequestSenderProtocol {
    func send<Model, Parser>(config: RequestConfig<Model, Parser>, completionHandler: @escaping (Result<Model, Error>) -> Void )
}

public class RequestSender: RequestSenderProtocol {

    let session = URLSession.shared
    let queue: DispatchQoS.QoSClass = .userInitiated
    var async: Bool = false

    public init(async: Bool = false) {
        if async {
            self.async = async
        }
    }

    public func send<ModelType, Parser>(config: RequestConfig<ModelType, Parser>, completionHandler: @escaping (Result<ModelType, Error>) -> Void) {

        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(NetworkServiceError.urlConstuctFailure("URL string can't be parsed to URL.")))
            return
        }

        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let data = data, let parsedModel = config.parser.parse(data: data) else {
                completionHandler(.failure(NetworkServiceError.decodeError("Received data can not be parsed.")))
                return
            }

            completionHandler(Result.success(parsedModel))
        }

        if async == true {
            let queue = self.queue
            DispatchQueue.global(qos: queue).async {
                task.resume()
            }
        } else {
            task.resume()
        }
    }
}
