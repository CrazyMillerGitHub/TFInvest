//
//  scrollCollectionView.swift
//  StockView
//
//  Created by Михаил Борисов on 03.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

final class ScrollCollectionView: UITableViewHeaderFooterView {

    // set leading constant to 40
    private let leadingConstant: CGFloat = 20

    // set top constant to 10
    private let topConstant: CGFloat = 0

    // set reuseIdentifier to ScrollCollectionView
    static let reuseIdentifier: String = String(describing: self)

    // crate label
    private lazy var sLabel: UILabel = {
        let label = UILabel()
        // set text to localizable value
        label.text = "Available exchange:"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CompanyCell.self, forCellWithReuseIdentifier: CompanyCell.reuseIdentifier)
        return collectionView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        // set background color to white
        tintColor = .white
        // add subview sLabel
        addSubview(sLabel)
        // add collectionView
        addSubview(collectionView)
        // prepare constraints
        prepareConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            sLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingConstant),
            sLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topConstant),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: sLabel.bottomAnchor, constant: 10)
        ])
    }
}

extension ScrollCollectionView: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.reuseIdentifier, for: indexPath) as? CompanyCell else {
            return UICollectionViewCell()
        }
        cell.companyName = "TV"
        return cell
    }

}
extension ScrollCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 5, left: leadingConstant, bottom: 0, right: 40)
    }
}
