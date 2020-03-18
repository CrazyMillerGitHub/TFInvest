//
//  AuthAssembly.swift
//  Assembly
//
//  Created by Саидов Тимур on 01.03.2020.
//

import Foundation
import Base

open class AuthAssembly: ModuleAssemblyProtocol {

    // MARK: Init

    public init() {}

    // MARK: - Module Assembly Protocol

    public func configure() -> UIViewController {
//        let viewController = UIViewController()
//        let viewModel = ViewModel()
//        viewController.viewModel = viewModel
//        viewModel.viewController = viewController
//        return viewController
        return UIViewController()
    }
}
