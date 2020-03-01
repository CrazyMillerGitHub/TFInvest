//
//  Assembly.swift
//  Pods-TFInvest
//
//  Created by Саидов Тимур on 25.02.2020.
//

import Foundation

public protocol ServiceContainerProtocol {
}
open class ServiceContainer {
}

public protocol ModuleContainerProtocol {
}
extension ModuleContainerProtocol {
}
open class ModuleContainer: ModuleContainerProtocol {
    
    let serviceContainer: ServiceContainerProtocol
    
    init(serviceContainer: ServiceContainerProtocol) {
        self.serviceContainer = serviceContainer
    }
}
