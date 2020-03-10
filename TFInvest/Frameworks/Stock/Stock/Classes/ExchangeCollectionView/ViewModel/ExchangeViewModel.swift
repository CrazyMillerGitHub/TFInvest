//
//  ExchangeViewModel.swift
//  Assembly
//
//  Created by Михаил Борисов on 10.03.2020.
//

import UIKit
import Core

class ExchangeViewModel: NSObject, UICollectionViewDelegate,
UICollectionViewDataSource, FetchDataPrototcol {

    // set leading constant to 40
    private let leadingConstant: CGFloat = 20

    // set items
    var items: [AvailableExchangeModel] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return items count
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExchangeCell.reuseIdentifier, for: indexPath) as? ExchangeCell else {
            return UICollectionViewCell()
        }
        // set exchange code
        cell.exchangeCode = items[indexPath.row].code
        return cell
    }

}

// MARK: - FlowLayout
extension ExchangeViewModel: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // set from each side padding
        return UIEdgeInsets(top: 5, left: leadingConstant, bottom: 0, right: 40)
    }
}
