//
//  extension+stackView.swift
//  ReusableProject
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

extension UIStackView {

    /// adding onboarding text field
    /// - Parameters:
    ///   - axis: axis (vertical or horizontal)
    ///   - spacing: spacing between views
    ///   - alignment: view alignment
    static func onboarding(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        // inizialize view
        let stackView = UIStackView()
        // set axis
        stackView.axis = axis
        // set spacing
        stackView.spacing = spacing
        // disable autogen constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

}
