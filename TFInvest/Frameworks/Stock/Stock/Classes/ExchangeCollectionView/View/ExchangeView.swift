//
//  scrollCollectionView.swift
//  StockView
//
//  Created by Михаил Борисов on 03.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import Core
import Services

// MARK: - Protocol with extension
public protocol FetchDataPrototcol {

    func fetchData(handler: @escaping (Result<[AvailableExchangeModel], Error>) -> Void)

    func fetchData(filter: String, handler: @escaping (Result<[AvailableStockModel], Error>) -> Void)
}

public extension FetchDataPrototcol {

    func fetchData(handler: @escaping (Result<[AvailableExchangeModel], Error>) -> Void) {
        let services = NetworkService()
        // load exchanges
        services.loadAvailableExchanges { (result) in
            // check which status we have
            switch result {
            case .success(let data):
                // if success return value accroding to model
                handler(.success(data))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }

    func fetchData(filter: String, handler: @escaping (Result<[AvailableStockModel], Error>) -> Void) {
        let services = NetworkService()
        services.loadAvailableStocks(exchangeCode: "US") { (result) in
            switch result {
            // check which status we have
            case .success(let data):
                // if success return value accroding to model
                handler(.success(data))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}

// MARK: - ExchangeView
final class ExchangeView: UITableViewHeaderFooterView {

    // set View Model
    private let viewModel: ExchangeViewModel = ExchangeViewModel()

    // set leading constant to 40
    private let leadingConstant: CGFloat = 20

    // set top constant to 10
    private let topConstant: CGFloat = 0

    // set reuseIdentifier to ScrollCollectionView
    static let reuseIdentifier: String = String(describing: self)

    // create label
    private lazy var sLabel: UILabel = {
        let label = UILabel()
        // set text to localizable value
        label.text = R.string.localizable.available_exchange()
        label.font = UIFont.roundedFont(15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // create scroll collectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.register(ExchangeCell.self, forCellWithReuseIdentifier: ExchangeCell.reuseIdentifier)
        return collectionView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        tintColor = .white
        // add subview sLabel
        addSubview(sLabel)
        // add collectionView
        addSubview(collectionView)
        // prepare constraints
        prepareConstraints()
        // perform delegate & dataSource
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        // fetch data
        performFetch()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - perform constraints
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

// MARK: - fetch data
private extension ExchangeView {

    func performFetch() {
        viewModel.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.viewModel.items = Array(items[2...])
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
