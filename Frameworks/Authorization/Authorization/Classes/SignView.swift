//
//  ViewController.swift
//  KeychainTest
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

open class SignView: UIViewController {

    lazy var slider: UISwitch = {
        let slider = UISwitch()
        slider.setOn(false, animated: true)
        return slider
    }()

    lazy var emailTextField = UITextField.container(.login)

    lazy var passwordTextField = UITextField.container(.password)

    lazy var fourPinLabel = UILabel.slideDescrition

    lazy var onboardingTitleLabel = UILabel.onboarding

    lazy var vStackView = UIStackView.onboarding(axis: .vertical, spacing: 10)

    lazy var hStackView = UIStackView.onboarding(axis: .horizontal, spacing: 10, alignment: .center)

    lazy var signButton = ElasticButton(of: .login, bgColor: .black)

    override open func loadView() {
        super.loadView()
        prepareStackView()
        prepareConstraints()
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // add target to signInButton
        signButton.addTarget(self, action: #selector(signAction), for: .touchUpInside)
        prepareDelegate()
    }

    private func prepareDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

}

// MARK: Prepare UI
private extension SignView {

    func prepareStackView() {
        view.addSubview(vStackView)
        view.addSubview(onboardingTitleLabel)
        view.addSubview(signButton)
        hStackView.addArrangedSubview(slider)
        hStackView.addArrangedSubview(fourPinLabel)
        vStackView.addArrangedSubview(emailTextField)
        vStackView.addArrangedSubview(passwordTextField)
        vStackView.addArrangedSubview(hStackView)
    }

    func prepareConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 46),
            passwordTextField.heightAnchor.constraint(equalToConstant: 46),
            vStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),

            onboardingTitleLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            onboardingTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                      constant: view.bounds.height * 0.1),
            signButton.heightAnchor.constraint(equalToConstant: 46),
            signButton.leadingAnchor.constraint(equalTo: vStackView.leadingAnchor),
            signButton.trailingAnchor.constraint(equalTo: vStackView.trailingAnchor),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70)
        ])
    }

}

@objc private extension SignView {

    func textFieldDidChange(_ textField: UITextField) {
        var firstTFChecked: Bool = false
        var secondTFChecked: Bool = false

        guard let textFieldContent = textField.text else {
            return
        }

        guard let textFieldType = textField.textContentType else {
            return
        }

        // идем проверять измененный textField
        if textFieldType == .emailAddress {
            firstTFChecked = textFieldContent.isValidEmail()

        } else if textFieldType == .password {
            secondTFChecked = textFieldContent.isValidPassword()
        }

        // идем проверять другой textField
        let currentTag = textField.tag
        if let otherTextField = textField.superview?.viewWithTag(currentTag + 1) as? UITextField, let passwordTextFieldContent = otherTextField.text {
            secondTFChecked = passwordTextFieldContent.isValidPassword()
        } else if let otherTextField = textField.superview?.viewWithTag(currentTag - 1) as? UITextField, let emailTextFieldContent = otherTextField.text {
            firstTFChecked = emailTextFieldContent.isValidEmail()
        }

        if firstTFChecked && secondTFChecked {
            signButton.toggleState(state: true)
        } else {
            signButton.toggleState(state: false)
        }

    }
}

// MARK: text field delegate for sign view
extension SignView: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // see which text fiekd we use
        switch textField {
        // case when our text field
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case _:
            passwordTextField.resignFirstResponder()
        }

        return true
    }

    // MARK: Public

    @objc private func signAction() {
        // view that need to be presented
        if !slider.isOn {

            let presentView = MainView()
            presentView.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async { [unowned self] in
                self.present(presentView, animated: true, completion: nil)
            }

            return
        } else {

            let presentView = PinView()
            presentView.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async { [unowned self] in
                self.present(presentView, animated: true, completion: nil)
            }
        }
    }

}
