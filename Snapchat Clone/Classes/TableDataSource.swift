//
//  TableDataSource.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/30/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

public typealias TableViewSelectionHandler = (IndexPath) -> ()

open class TableDataSource<Provider: TableDataProvider, Cell: UITableViewCell> :
    NSObject, UITableViewDataSource, UITableViewDelegate
where Provider.T == Cell.T, Cell: ConfigurableCell {
    
    var provider: Provider
    var tableView: UITableView
    
    var selectionHandler: TableViewSelectionHandler?
    
    init (tableView: UITableView, provider: Provider) {
        self.tableView = tableView
        self.provider = provider
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return provider.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfRows(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as? Cell {
            if let item = provider.item(at: indexPath) {
                cell.configureCell(with: item, at: indexPath)
                round(cellsCornersFor: cell, atIndexPath: indexPath)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHandler?(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return provider.cellHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return provider.sectionHeaderViews[section]
    }
    
    private func round(cellsCornersFor cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        cell.layoutIfNeeded()
        print(cell.frame)
        cell.layoutIfNeeded()
        
        var path = UIBezierPath()
        let maskLayer = CAShapeLayer()

        if (indexPath.row == 0) {
            path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 7, height: 7))
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 7, height: 7))
        } else {
            path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [], cornerRadii: .zero)
        }

        maskLayer.path = path.cgPath
        cell.layer.mask = maskLayer
    }
}


