//
//  TableViewAdapter.swift
//  Base
//
//  Created by Саидов Тимур on 01.03.2020.
//

import Foundation

protocol Adaptable: UITableViewCell {
    static var identifier: String { get }
    func setup(with item: Decodable)
}

class TableViewAdapter<Model: Decodable, Cell: Adaptable>: NSObject, UITableViewDataSource {

    // MARK: Private Properties

    private var tableView: UITableView!
    private var items: [Model] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Init

    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
    }

    // MARK: Public

    func setup(items: [Model]) {
        self.items = items
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Adaptable else { return UITableViewCell() }
        let item = items[indexPath.item]
        cell.setup(with: item)
        return cell
    }
}
