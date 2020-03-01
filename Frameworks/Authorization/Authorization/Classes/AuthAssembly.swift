//
//  AuthAssembly.swift
//  Assembly
//
//  Created by Саидов Тимур on 01.03.2020.
//

import Foundation
import Base

class AuthAssembly: ModuleAssemblyProtocol {
    
    var moduleContainer: ModuleContainerProtocol?
    
    init(moduleContainer: ModuleContainerProtocol) {
        self.moduleContainer = moduleContainer
    }
    
    func configure() -> UIViewController {
//        let viewController = UIViewController()
//        let viewModel = ViewModel()
//        viewController.viewModel = viewModel
//        viewModel.viewController = viewController
//        return viewController
        return UIViewController()
    }
}
