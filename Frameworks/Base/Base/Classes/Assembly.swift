//
//  Assembly.swift
//  Pods-TFInvest
//
//  Created by Саидов Тимур on 25.02.2020.
//

import Foundation

public protocol ServiceContainerGenerationProtocol {
    func service<T: Service>() -> T
}
public protocol ServiceContainerDelegate {}
public typealias ServiceContainerProtocol = ServiceContainerGenerationProtocol & ServiceContainerDelegate
open class ServiceContainer: ServiceContainerProtocol {

    public func service<T: Service>() -> T {
        let service = T.init()
        return service
    }
}

public protocol ModuleAssemblyContainerProtocol {
    func moduleAssembly<T: ModuleAssembly>() -> T
    func moduleAssembly<T: ModuleAssembly>(with serviceContainer: ServiceContainerProtocol?) -> T
}
open class ModuleAssemblyContainer: ModuleAssemblyContainerProtocol {

    public func moduleAssembly<T: ModuleAssembly>() -> T {
        let moduleAssembly = T.init()
        return moduleAssembly
    }

    public func moduleAssembly<T: ModuleAssembly>(with serviceContainer: ServiceContainerProtocol?) -> T {
        let moduleAssembly = T.init(moduleAssemblyContainer: self,
                                    serviceContainer: serviceContainer)
        return moduleAssembly
    }
}
