//
//  Assembly.swift
//  Authorization
//
//  Created by Саидов Тимур on 01.03.2020.
//

import Foundation
import Base
import Authorization

struct ModuleAssemblyFactory: FactoryProtocol {
    typealias `Type` = ModuleAssemblyProtocol

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

open class DIModuleContainer: Resolver {

    // MARK: Static Properties

    public static let shared = DIModuleContainer()

    // MARK: Private Properties

    private var factories: [ModuleAssemblyFactory] = []

    // MARK: Init

    private init() {}

    // MARK: Register

    public func register<T: ModuleAssemblyProtocol>(_ type: T.Type, instance: T) {
        register(type) { _ in instance }
    }

    public func register<ServiceType: ModuleAssemblyProtocol>(_ type: ServiceType.Type, _ factory: @escaping (Resolver) -> ServiceType) {
        assert(!factories.contains(where: { $0.type == type }))
        let newFactory = ModuleAssemblyFactory(type, resolve: { resolver in
            factory(resolver)
        })
        factories += [newFactory]
    }

    // MARK: Resolver

    public func resolve<ServiceType: ModuleAssemblyProtocol>(_ type: ServiceType.Type) -> ServiceType {
        guard
            let factory = factories.first(where: { $0.type == type }),
            let type = factory.resolve(self) as? ServiceType
            else {
                fatalError("No suitable factory found")
        }
        return type
    }
}
