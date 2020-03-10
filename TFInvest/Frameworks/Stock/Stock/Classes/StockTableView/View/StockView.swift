//
//  ViewController.swift
//  StockView
//
//  Created by Михаил Борисов on 02.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

open class StockView: UIViewController {

    private let viewModel: StockViewModel
    private var safeArea: UILayoutGuide!

    public init(viewModel: StockViewModel = StockViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ExchangeView.self, forHeaderFooterViewReuseIdentifier: ExchangeView.reuseIdentifier)
        return tableView
    }()

    override public func loadView() {
        super.loadView()
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = "Investt"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner(onView: self.view)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        fetchData()
    }

    func fetchData() {
        viewModel.fetchData(filter: "US") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.viewModel.items = data.filter { !$0.description.isEmpty }
                self.tableView.reloadData()
                self.removeSpinner()
            case .failure(let error):
                // print error
                print(error.localizedDescription)
            }
        }
    }

}
extension StockView: UISearchResultsUpdating, UISearchBarDelegate {

    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {

            viewModel.fileteredItems = viewModel.items.filter { item in
                item.description.lowercased().contains(text.lowercased())
            }

            self.tableView.reloadData()
        }
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()

        // Clear items
        viewModel.fileteredItems = []

        // Update Table View
        tableView.reloadData()
    }

}
