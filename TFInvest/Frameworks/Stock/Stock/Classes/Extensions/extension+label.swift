//
//  extension+label.swift
//  Stock
//
//  Created by Михаил Борисов on 10.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

extension UILabel {

    static var stockTitle: UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.roundedFont(17, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static var stockDescription: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 1
        label.font = UIFont.roundedFont(14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.layer.cornerRadius = 25
        label.layer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}
