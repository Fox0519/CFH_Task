//
//  BaseAdapter.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

// Base Adapter
open class BaseAdapter<TableViewSectionModel: ISectionModel>:
    NSObject,
    UITableViewDelegate,
    UITableViewDataSource,
    UIScrollViewDelegate,
    ITableEvent {
    
    open var didSelect: TableComplete?
    public weak var tableView: UITableView?
    public init(_ tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.sectionHeaderHeight = 0.0
        self.tableView?.contentInsetAdjustmentBehavior = .never
    }
    
    public var models: [TableViewSectionModel]?
    open func updateData(models: [TableViewSectionModel]) {
        self.models = models
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    // MARK: ---------- UITableView DataSource ----------
    open func numberOfSections(in tableView: UITableView
    ) -> Int {
        guard models != nil else { return 0 }
        return (models?.count) ?? 0
    }
    
    open func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        guard models?[section] != nil else { return 0 }
        return (models?[section].rowModels.count) ?? 0
    }
    
    open func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if let section = models?[safe: indexPath.section] {
            let rowModels = section.rowModels
            if let rowModel = rowModels[safe: indexPath.row] {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: rowModel.getBundleCellViewIdentifier(),
                    for: indexPath)
                
                if let cell = cell as? ICellViewBase {
                    cell.setupView(rowModel: rowModel)
                }
                cell.layoutIfNeeded()
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // MARK: ---------- UITableView Delegate   ----------
    open func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            didSelect?(indexPath,cell)
        }
    }
    
    open func tableView(
        _ tableView: UITableView,
        didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UIScrollViewDelegate
    open func scrollViewDidScroll(
        _ scrollView: UIScrollView) {
        
    }
    
    open func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
        
    }
}
