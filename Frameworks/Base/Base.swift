//
//  Base.swift
//  Pods-TFInvest
//
//  Created by Саидов Тимур on 25.02.2020.
//

import UIKit

public protocol BaseControllerProtocol: class {
    var viewModel: BaseViewModelProtocol? { get set }
    var configuratorsContainer: ConfiguratorsContainerProtocol? { get set }
    var modulesContainer: ModulesContainerProtocol? { get set }
}
public protocol BaseViewModelProtocol: class {
    var params: Decodable? { get set }
    var viewController: BaseControllerProtocol? { get set }
    var servicesContainer: ServicesContainerProtocol? { get set }
}

public class BaseController: UIViewController, BaseControllerProtocol {
    
    public var viewModel: BaseViewModelProtocol?
    public var configuratorsContainer: ConfiguratorsContainerProtocol?
    public var modulesContainer: ModulesContainerProtocol?
}
public class BaseViewModel: BaseViewModelProtocol {
    
    public weak var viewController: BaseControllerProtocol?
    public var servicesContainer: ServicesContainerProtocol?
    public var params: Decodable?

    required public init(params: Decodable?) {
        self.params = params
    }
}

public protocol ConfiguratorProtocol {
    func configure<T: BaseControllerProtocol, U: BaseViewModelProtocol>(with viewController: T, _ viewModel: U)
    func configure<T: BaseControllerProtocol, U: BaseViewModelProtocol, Z: ServicesContainerProtocol>(with viewController: T, _ viewModel: U, servicesContainer: Z)
    func configure<T: BaseControllerProtocol, U: BaseViewModelProtocol, V: ConfiguratorsContainerProtocol, W: ModulesContainerProtocol, Z: ServicesContainerProtocol>(with viewController: T, _ viewModel: U,
                                                                                                                                                                      configuratorsContainer: V, modulesContainer: W, servicesContainer: Z)
}
public class BaseConfigurator: ConfiguratorProtocol {
    
    required public init() {}
    
    public func configure<T, U>(with viewController: T, _ viewModel: U) where T : BaseControllerProtocol, U : BaseViewModelProtocol {}
    public func configure<T, U, Z>(with viewController: T, _ viewModel: U, servicesContainer: Z) where T : BaseControllerProtocol, U : BaseViewModelProtocol, Z : ServicesContainerProtocol {}
    public func configure<T, U, V, W, Z>(with viewController: T, _ viewModel: U,
                                         configuratorsContainer: V, modulesContainer: W, servicesContainer: Z) where T : BaseControllerProtocol, U : BaseViewModelProtocol, V : ConfiguratorsContainerProtocol, W : ModulesContainerProtocol, Z : ServicesContainerProtocol {}
}

public class BaseService {
    
    required public init() {}
}
