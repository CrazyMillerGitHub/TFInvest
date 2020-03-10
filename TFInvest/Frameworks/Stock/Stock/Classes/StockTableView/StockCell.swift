//
//  CustomCell.swift
//  StockView
//
//  Created by Михаил Борисов on 02.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import Base

class StockCell: UITableViewCell {

    // set identifier
    static var identifier: String = String(describing: self)

    // set leading constraint
    var leadingConstant: CGFloat = 15 {
        didSet {
            self.layoutIfNeeded()
        }
    }

    // if title changed, change in label text
    var stockTitle: String = String() {
        didSet {
            stockDescriptionLabel.text = stockTitle
        }
    }

    // set stock name
    var stockName: String = "" {
        didSet {
            stockLabel.text = stockName
        }
    }

    // return stock lbale
    lazy private var stockLabel: UILabel = UILabel.stockTitle

    // return description Label
    lazy private var stockDescriptionLabel: UILabel = UILabel.stockDescription

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        addSubview(stockLabel)
        addSubview(stockDescriptionLabel)
        prepareConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Constraint extension
private extension StockCell {

    func prepareConstraint() {
        NSLayoutConstraint.activate([
            stockDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingConstant),
            stockDescriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            stockDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            stockDescriptionLabel.widthAnchor.constraint(equalTo: stockDescriptionLabel.heightAnchor, multiplier: 1),
            stockLabel.leadingAnchor.constraint(equalTo: stockDescriptionLabel.trailingAnchor, constant: leadingConstant),
            stockLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -leadingConstant),
            stockLabel.centerYAnchor.constraint(equalTo: stockDescriptionLabel.centerYAnchor)
        ])
    }
}
