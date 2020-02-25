//
//  extension+label.swift
//  ReusableProject
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

extension UILabel {

    static var slideDescrition: UILabel {
        let label = UILabel()
        label.text = "Добавить 4-пинкод"
        label.font = UIFont.roundedFont(13, weight: .medium)
        label.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1.0)
        return label
    }

    static var onboarding: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: "Hi,\nLet’s get to know \neach other closer", attributes: [
            .font: UIFont.roundedFont(17, weight: .bold),
            .foregroundColor: UIColor.black,
            .kern: 0.18
        ])
        attributedString.addAttributes([
            .font: UIFont.roundedFont(36, weight: .bold)
        ], range: NSRange(location: 0, length: 3))
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}
