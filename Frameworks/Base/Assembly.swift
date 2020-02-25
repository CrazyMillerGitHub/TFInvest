//
//  Assembly.swift
//  Pods-TFInvest
//
//  Created by Саидов Тимур on 25.02.2020.
//

import Foundation

public protocol ConfiguratorsContainerProtocol {
    func configurator<T: BaseConfigurator>() -> T
}
open class ConfiguratorsContainer: ConfiguratorsContainerProtocol {
    
    public func configurator<T: BaseConfigurator>() -> T {
        let configurator = T.init()
        return configurator
    }
}

public protocol ModulesContainerProtocol {
    func viewController<T: BaseController>() -> T
    func viewModel<U: BaseViewModel>(params: Decodable?) -> U
}
open class ModulesContainer: ModulesContainerProtocol {
    
    public func viewController<T>() -> T where T : BaseController {
        return T.init()
    }
    
    public func viewModel<U>(params: Decodable?) -> U where U : BaseViewModel {
        return U.init(params: params)
    }
}

public protocol ServicesContainerProtocol {
    func service<T: BaseService>() -> T
}
open class ServicesContainer: ServicesContainerProtocol {
    
    public func service<T: BaseService>() -> T {
        return T.init()
    }
}
