//
//  Resolver.swift
//  Assembly
//
//  Created by Timur Saidov on 08.03.2020.
//

import Foundation
import Base

public protocol Resolver {
    func resolve<ServiceType: ModuleAssemblyProtocol>(_ type: ServiceType.Type) -> ServiceType
    func resolve<ServiceType: ServiceAssemblyProtocol>(_ type: ServiceType.Type) -> ServiceType
}
public extension Resolver {
    
    func resolve<ServiceType: ModuleAssemblyProtocol>(_ type: ServiceType.Type) -> ServiceType {
        fatalError("implement resolve<ServiceType: ModuleAssemblyProtocol>() in ModuleAssembly")
    }
    
    func resolve<ServiceType: ServiceAssemblyProtocol>(_ type: ServiceType.Type) -> ServiceType {
        fatalError("implement assembleModule() in ModuleAssembly")
    }
}

protocol FactoryProtocol {
    associatedtype `Type`
    func resolve(_ resolver: Resolver) -> Type
}
