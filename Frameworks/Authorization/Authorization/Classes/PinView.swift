//
//  PinView.swift
//  ReusableProject
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

open class PinView: UIViewController {

    public enum PinType {
        case authorized
        case nonAuthorized
    }

    var pinType: PinType = .nonAuthorized

    lazy var pinStackView = UIStackView.onboarding(axis: .horizontal, spacing: 20)

    lazy var confirmButton = ElasticButton(of: .confirmation, bgColor: .black)

    private var result: [String] = Array(repeatElement("", count: 4))

    lazy var pinLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter 4-pin"
        label.font = UIFont.roundedFont(24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var textFieldCollection: [UITextField] = {
        var collection = [UITextField]()
        for number in 1...4 {
            collection.append(UITextField.pin(number: number))
        }
        return collection
    }()

    private var isButtonActive: Bool = false {

        didSet {
            if isButtonActive != oldValue {
                confirmButton.toggleState(state: isButtonActive)
            }
        }

    }

    public init(_ type: PinType = .nonAuthorized) {
        super.init(nibName: nil, bundle: nil)
        self.pinType = type
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(pinLabel)
        view.addSubview(pinStackView)
        view.addSubview(confirmButton)
        textFieldCollection.forEach { [weak self] pinTextField in
            self?.pinStackView.addArrangedSubview(pinTextField)
            pinTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        prepareConstraints()
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }

}

private extension PinView {

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
        let presentView = MainView()
        presentView.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(presentView, animated: true, completion: nil)
        }
    }

}
