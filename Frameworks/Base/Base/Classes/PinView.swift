//
//  PinView.swift
//  ReusableProject
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

class PinView: UIViewController {

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

    override func loadView() {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareConstraints()
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
        if textField.text!.count > 1 {
            textField.text?.removeFirst()
        }
        result[textField.tag - 1] = textField.text ?? ""
        // находим, существует ли textField

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            if textField.text! != "" {
                confirmButton.toggleState(state: false)
                nextResponder.becomeFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
            if result.joined(separator: "") != "1234" {
                confirmButton.toggleState(state: true)
                textFieldCollection.forEach { textField in
                    let color = CABasicAnimation(keyPath: "borderColor")
                    color.fromValue = textField.layer.borderColor
                    color.toValue = UIColor.red.cgColor
                    color.isRemovedOnCompletion = false
                    color.duration = 0.5
                    color.fillMode = .both
                    textField.layer.add(color, forKey: nil)
                }
            }
        }
    }

}