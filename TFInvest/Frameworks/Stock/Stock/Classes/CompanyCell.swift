//
//  CompanyCell.swift
//  StockView
//
//  Created by Михаил Борисов on 03.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

final class CompanyCell: UICollectionViewCell {

    // set reuseIdentifier to ScrollCollectionView
    static let reuseIdentifier: String = String(describing: self)

    var companyName: String = "" {
        didSet {
            companyLabel.text = companyName
        }
    }

    private var companyLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        companyLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(companyLabel)
        layer.cornerRadius = frame.height / 2
        layer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
