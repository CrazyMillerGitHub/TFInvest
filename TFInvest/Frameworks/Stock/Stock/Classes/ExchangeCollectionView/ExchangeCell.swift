//
//  CompanyCell.swift
//  StockView
//
//  Created by Михаил Борисов on 03.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

final class ExchangeCell: UICollectionViewCell {

    // set reuseIdentifier to ScrollCollectionView
    static let reuseIdentifier: String = String(describing: self)

    var exchangeCode: String = String() {
        didSet {
            companyLabel.text = exchangeCode
        }
    }

    // set company name
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        // aligment to center
        label.textAlignment = .center
        // set font to 11
        label.font = UIFont.roundedFont(11, weight: .medium)
        // set text color
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        return label
    }()

    override var isSelected: Bool {
        didSet {
            // animate when state changed
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                // set background of layer according state
                self.layer.backgroundColor = self.isSelected ? UIColor.black.cgColor :
                    UIColor.black.withAlphaComponent(0.2).cgColor
                // change text Color
                self.companyLabel.textColor = self.isSelected ? UIColor.white : UIColor.black.withAlphaComponent(0.8)
                // layout if need to presenet animation
                self.layoutIfNeeded()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        // set size for company label
        companyLabel.frame.size = CGSize(width: frame.width, height: frame.height)
        // set background color to light gray (alpha = 0.2)
        layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        // set roudned corner for layer
        layer.cornerRadius = frame.height / 2
        // add subview
        addSubview(companyLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 1.0)
    }
}
