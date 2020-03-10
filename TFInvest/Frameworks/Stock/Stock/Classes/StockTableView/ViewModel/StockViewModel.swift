//
//  StockViewModel.swift
//  Stock
//
//  Created by Михаил Борисов on 05.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import Core

open class StockViewModel: NSObject, UITableViewDelegate, UITableViewDataSource, FetchDataPrototcol {

    public var fileteredItems: [AvailableStockModel] = []

    public var items = [AvailableStockModel]()

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !fileteredItems.isEmpty {
            return fileteredItems.count
        }

        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.identifier, for: indexPath) as? StockCell else {
            return UITableViewCell()
        }
        let cellItems = !fileteredItems.isEmpty ? fileteredItems : items
        // perform data to cell
        cell.stockName = cellItems[indexPath.row].description
        cell.stockTitle = cellItems[indexPath.row].displaySymbol
        return cell
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ExchangeView.reuseIdentifier)
            as? ExchangeView
            else {
                return nil
        }
        return view
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
