//
//  Base.swift
//  Pods-TFInvest
//
//  Created by Саидов Тимур on 25.02.2020.
//

import UIKit

public protocol TransitionModel { }

public protocol ModuleTransitionHandler where Self: UIViewController {}

public extension ModuleTransitionHandler {

    func present<ModuleType: ModuleAssemblyProtocol>(with model: TransitionModel, moduleType: ModuleType,
                                                     modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        let view = moduleType.configure(with: model)
        view.modalPresentationStyle = modalPresentationStyle
        present(view, animated: true, completion: nil)
    }

    func presentModal<ModuleType: ModuleAssemblyProtocol>(with model: TransitionModel, moduleType: ModuleType,
                                                          modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        let view = moduleType.configure(with: model)
        let nc = UINavigationController(rootViewController: view)
        nc.modalPresentationStyle = modalPresentationStyle
        present(nc, animated: true, completion: nil)
    }

    func present<ModuleType: ModuleAssemblyProtocol>(moduleType: ModuleType,
                                                     modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        let view = moduleType.configure()
        view.modalPresentationStyle = modalPresentationStyle
        present(view, animated: true, completion: nil)
    }

    func show<ModuleType: ModuleAssemblyProtocol>(with model: TransitionModel, moduleType: ModuleType) {
        let view = moduleType.configure(with: model)
        show(view, sender: nil)
    }

    func pop() {
        navigationController?.popViewController(animated: true)
    }

    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }

    func push<ModuleType: ModuleAssemblyProtocol>(with model: TransitionModel, moduleType: ModuleType) {
        let view = moduleType.configure(with: model)
        navigationController?.pushViewController(view, animated: true)
    }

    func push<ModuleType: ModuleAssemblyProtocol>(moduleType: ModuleType) {
        let view = moduleType.configure()
        navigationController?.pushViewController(view, animated: true)
    }

    func closeModule(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
}

/// Фабрики.
public protocol ModuleContainerProtocol {
    func authAssembly() -> ModuleAssemblyProtocol
}

public protocol ServiceContainerProtocol {
//    func keychainServiceAssembly() -> ServiceAssemblyProtocol
}

/// Ассемблы.
public protocol ModuleAssemblyProtocol {
    func configure() -> UIViewController
    func configure(with model: TransitionModel) -> UIViewController
}
public extension ModuleAssemblyProtocol {

    func configure() -> UIViewController {
        fatalError("implement assembleModule() in ModuleAssembly")
    }

    func configure(with model: TransitionModel) -> UIViewController {
        fatalError("implement assembleModule(with model: TransitionModel) in ModuleAssembly")
    }
}

public protocol ServiceProtocol {}
public protocol ServiceAssemblyProtocol {
//    func configure<T: ServiceProtocol>() -> T
}
