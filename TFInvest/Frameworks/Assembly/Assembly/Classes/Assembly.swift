//
//  Assembly.swift
//  Authorization
//
//  Created by Саидов Тимур on 01.03.2020.
//

import Foundation
import Base
import Authorization

open class ServiceContainer: ServiceContainerProtocol {

    public init() {}

    // MARK: - Service Container Protocol

//    public func keychainServiceAssembly() -> ServiceAssemblyProtocol {
//        let keychainServiceAssembly = KeychainServiceAssembly()
//        return keychainServiceAssembly
//    }
}

open class ModuleContainer: ModuleContainerProtocol {

    let serviceContainer: ServiceContainerProtocol

    public init(serviceContainer: ServiceContainerProtocol) {
        self.serviceContainer = serviceContainer
    }

    // MARK: - Module Container Protocol

    public func authAssembly() -> ModuleAssemblyProtocol {
        let authAssembly = AuthAssembly(moduleContainer: self)
        return authAssembly
    }
}