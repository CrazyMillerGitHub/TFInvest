//
//  ServiceContainer.swift
//  Assembly
//
//  Created by Timur Saidov on 08.03.2020.
//

import Foundation
import Base
import Authorization

struct ServiceAssemblyFactory: FactoryProtocol {
    typealias `Type` = ServiceAssemblyProtocol


    // MARK: Public Properties

    let type: `Type`.Type

    // MARK: Private Properties

    private let resolve: (Resolver) -> `Type`

    // MARK: Init

    init(_ type: `Type`.Type, resolve: @escaping (Resolver) -> Type) {
        self.type = type
        self.resolve = resolve
    }

    // MARK: - Factory Protocol

    func resolve(_ resolver: Resolver) -> `Type` {
        return resolve(resolver)
    }
}

open class DIServiceContainer: Resolver {
    // MARK: Static Properties

    public static let shared = DIServiceContainer()

    // MARK: Private Properties

    private var factories: [ServiceAssemblyFactory] = []

    // MARK: Init

    private init() {}

    // MARK: Register

    public func register<T: ServiceAssemblyProtocol>(_ type: T.Type, instance: T) {
        register(type) { _ in instance }
    }

    public func register<ServiceType: ServiceAssemblyProtocol>(_ type: ServiceType.Type, _ factory: @escaping (Resolver) -> ServiceType) {
        assert(!factories.contains(where: { $0.type == type }))
        let newFactory = ServiceAssemblyFactory(type, resolve: { resolver in
            factory(resolver)
        })
        factories += [newFactory]
    }

    // MARK: Resolver

    public func resolve<ServiceType: ServiceAssemblyProtocol>(_ type: ServiceType.Type) -> ServiceType {
        guard
            let factory = factories.first(where: { $0.type == type }),
            let type = factory.resolve(self) as? ServiceType
            else {
                fatalError("No suitable factory found")
        }
        return type
    }
}
