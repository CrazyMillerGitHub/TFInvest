//
//  ElasticButton.swift
//  ReusableProject
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

class ElasticButton: UIButton {

    var isActive = false

    enum ElasticType: String {
        case login = "Log In"
        case logout = "Log Out"
        case confirmation = "Confirm"
    }

    init(of type: ElasticType = .login, bgColor: UIColor = .black) {
        super.init(frame: .zero)
        backgroundColor = bgColor
        layer.cornerRadius = 15
        setTitle(type.rawValue, for: .normal)
        titleLabel?.font = UIFont.roundedFont(17, weight: .semibold)
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 20
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        alpha = 0.1
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open var isHighlighted: Bool {
           didSet {
               if self.isHighlighted {
                   UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
                       self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                   }, completion: nil)
               } else {
                   UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
                       self.transform = .identity
                   }, completion: nil)
               }
           }
       }

    func toggleState(state: Bool) {
        isActive = state
        self.isUserInteractionEnabled = isActive
        UIView.animate(withDuration: 0.5) {
            self.alpha = self.isActive == true ? 1.0 : 0.1
        }
    }
}
