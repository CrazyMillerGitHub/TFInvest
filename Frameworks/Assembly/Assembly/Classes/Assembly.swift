//
//  Assembly.swift
//  Authorization
//
//  Created by Саидов Тимур on 01.03.2020.
//

import Foundation
import Base
import Authorization

public protocol ServiceContainerProtocol {
}
open class ServiceContainer: ServiceContainerProtocol {

    required public init() {}
}

open class ModuleContainer: ModuleContainerProtocol {

    let serviceContainer: ServiceContainerProtocol

    public init(serviceContainer: ServiceContainerProtocol) {
        self.serviceContainer = serviceContainer
    }


    // MARK: - Module Container Protocol

    public func authAssembly() -> ModuleAssemblyProtocol {
        let authAssemly = AuthAssembly(moduleContainer: self)
        return authAssemly
    }
}
