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
        //slider.addTarget(self, action: #selector(slideAction(_:)), for: .valueChanged)
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

    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
