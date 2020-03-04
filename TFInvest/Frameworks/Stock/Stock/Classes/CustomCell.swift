//
//  CustomCell.swift
//  StockView
//
//  Created by Михаил Борисов on 02.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    static var identifier = "stockCell"

//    var leadingConstant: CGFloat = 45 {
//        didSet {
//            self.layoutIfNeeded()
//        }
//    }
//
//    private var stockImage: UIImage {
//        didSet {
//            stockImageView.image = stockImage
//        }
//    }
//
//    private var stockName: String {
//        didSet {
//            stockLabel.text = stockName
//        }
//    }
//
//    lazy private var stockLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
//        label.textColor = UIColor.black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    lazy private var stockImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .red
    }

//    func perform(image: UIImage, stockName: String) {
//        self.stockImage = image
//        self.stockName = stockName
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Constraint extension
private extension CustomCell {

    func prepareConstraint() {
        NSLayoutConstraint.activate([
//            stockImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingConstant),
//            stockImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
