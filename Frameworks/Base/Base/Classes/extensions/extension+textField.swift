//
//  extension+textField.swift
//  ReusableProject
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

extension UITextField {

    enum TextFieldType {
        case login
        case password
    }

    /// Onboarding Container
    /// - Parameter type: type of TextField
    static func container(_ type: TextFieldType) -> UITextField {
        // inizialize textField
        let textField = UITextField()
        // set background color textField
        textField.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        // set cornerRadius
        textField.layer.cornerRadius = 15
        // disable autocapitalization
        textField.autocapitalizationType = .none
        // set clear button
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // enable leftView as always
        textField.leftViewMode = .always
        // set leftView
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        // create SF font: size 17, type: medium

        switch type {
        case .login:
            textField.autocorrectionType = .no
            textField.textContentType = .emailAddress
            textField.tag = 1
            textField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                 attributes: [NSAttributedString.Key.font: UIFont.roundedFont(17, weight: .regular)])
        case .password:
            textField.textContentType = .password
            textField.tag = 2
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }

    /// pin text field
       /// - Parameter number: set number of textField
       static func pin(number: Int) -> UITextField {
           // inizialize textField
           let textField = UITextField()
           textField.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
           // set cornerRadius
           textField.layer.cornerRadius = 15
           // disable autocapitalization
           textField.autocapitalizationType = .none
           // set clear button
           textField.textAlignment = .center
           // set keyboard type to number
           textField.keyboardType = .numberPad
           // set tag according to number
           textField.tag = number
           // set border for textField
           textField.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0).cgColor
           // seto border width
           textField.layer.borderWidth = 2

           textField.font = UIFont.roundedFont(24, weight: .bold)

           NSLayoutConstraint.activate([
               textField.widthAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1.0)
           ])

           return textField
       }

}
