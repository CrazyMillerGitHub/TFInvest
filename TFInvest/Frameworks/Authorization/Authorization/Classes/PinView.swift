//
//  PinView.swift
//  ReusableProject
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import Stock
import News
import SwiftUI

// MARK: - MainTabBarController
open class MainTabBarController: UITabBarController {

    open override func viewDidLoad() {
        let firstViewController = UINavigationController(rootViewController: StockView())

        firstViewController.tabBarItem = UITabBarItem(title: "Stock", image: UIImage(systemName: "checkmark.seal.fill"), tag: 0)

        let postsView = PostsView()

        let secondViewController = UIHostingController(rootView: postsView)

        secondViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "doc.fill"), tag: 1)

        let tabBarList = [firstViewController, secondViewController]

        viewControllers = tabBarList
    }
}

open class PinView: UIViewController {

    // MARK: - Prepare UI

    // Enum to choose which type should be our pinView
    public enum PinType {
        // User authorized early
        case authorized
        // We don't know who is it
        case nonAuthorized
    }

    // dependency of our pin Type
    private var pinType: PinType

    // stackView of our textField
    lazy var pinStackView = UIStackView.onboarding(axis: .horizontal, spacing: 20)

    // add confirm button
    lazy var confirmButton = ElasticButton(of: .confirmation, bgColor: .black)

    // add variable that contains result of pin textField
    private var result: [String] = Array(repeatElement("", count: 4))

    // return pinLable
    private lazy var pinLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.four_pin()
        label.font = UIFont.roundedFont(24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // add collection of textField that will be used in stacjView
    lazy var textFieldCollection: [UITextField] = {
        // create an empy textField
        var collection = [UITextField]()
        // add textField to collection
        for number in 1...4 {
            collection.append(UITextField.pin(number: number))
        }
        // return collections
        return collection
    }()

    // MARK: Button switcher
    private var isButtonActive: Bool = false {

        didSet {
            // is value did changed
            if isButtonActive != oldValue {
                confirmButton.toggleState(state: isButtonActive)
            }
        }

    }

    // MARK: - Init

    /// public init
    /// - Parameter type: dependendency injection with default value as .nonAuthorized
    public init(_ type: PinType = .nonAuthorized) {
        // dependency injection
        self.pinType = type
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Load our view
    override open func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(pinLabel)
        view.addSubview(pinStackView)
        view.addSubview(confirmButton)
        textFieldCollection.forEach { [weak self] pinTextField in
            self?.pinStackView.addArrangedSubview(pinTextField)
            pinTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            // accessibilityIdentifier for UI Testing
            pinTextField.accessibilityIdentifier = "pin_textfield_\(pinTextField.tag)"
        }
        // accessibilityIdentifier for UI Testing
        pinLabel.accessibilityIdentifier = "pin_label"
        confirmButton.accessibilityIdentifier = "confirm_button"
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        // prepare constraints
        prepareConstraints()
        // add target to button
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }

}

// MARK: - Prepare constraints
private extension PinView {

    // prepare constraints
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            pinStackView.heightAnchor.constraint(equalToConstant: 46),
            pinStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pinStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            pinLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pinLabel.bottomAnchor.constraint(equalTo: pinStackView.topAnchor, constant: -50),

            confirmButton.heightAnchor.constraint(equalToConstant: 46),
            confirmButton.leadingAnchor.constraint(equalTo: pinStackView.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: pinStackView.trailingAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70)
        ])
    }
}

@objc private extension PinView {

    func textFieldDidChange(_ textField: UITextField) {
        // находим следующий tag для textField
        let nextTag = textField.tag + 1
        // проверяем пустой ли textField
        if let text = textField.text, text.count > 1 {
            textField.text?.removeFirst()
        }

        result[textField.tag - 1] = textField.text ?? ""
        // находим, существует ли textField

        if let nextResponder = textField.superview?.viewWithTag(nextTag), let text = textField.text {
            if !text.isEmpty {
                nextResponder.becomeFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
        }

        print(result.filter { $0 != "" }.count == 4)
        isButtonActive = result.filter { $0 != "" }.count == 4
    }

    // MARK: - Button Action
    func confirmAction() {
        // check which pin type we have
        switch pinType {
        case .authorized:
            do {
                guard let currectPin = try KeychainService.shared.get(forKey: "userPin") else {
                    return
                }

                if currectPin == result.joined(separator: "") {
                    presentMainView()
                }
            } catch let error {
                print(error)
            }
        case .nonAuthorized:
            do {
                guard let value = result.joined(separator: "").data(using: .utf8) else {
                    return
                    }
                try KeychainService.shared.set(value: value, forKey: "userPin")
            } catch let error {
                print(error)
            }

            UserDefaults.standard.set(true, forKey: "isUserRegistered")
            presentMainView()
        }
    }

    // MARK: - Present Main View
    func presentMainView() {
        let presentView = MainTabBarController()
        presentView.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(presentView, animated: true, completion: nil)
        }
    }

}
