//
//  AuthAssembly.swift
//  Assembly
//
//  Created by Саидов Тимур on 01.03.2020.
//

import Foundation
import Base

open class AuthAssembly: ModuleAssemblyProtocol {

    public var moduleContainer: ModuleContainerProtocol?

    public init(moduleContainer: ModuleContainerProtocol) {
        self.moduleContainer = moduleContainer
    }

    public func configure() -> UIViewController {
//        let viewController = UIViewController()
//        let viewModel = ViewModel()
//        viewController.viewModel = viewModel
//        viewModel.viewController = viewController
//        return viewController
        return UIViewController()
    }
}
