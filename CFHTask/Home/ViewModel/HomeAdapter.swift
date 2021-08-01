//
//  HomeAdapter.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

public class HomeSectionModel:ISectionModel,
                       IHeaderModel,
                       IFooterModel
{
    public var headerViewModel: IHeaderFooterViewModel?
    public var footerViewModel: IHeaderFooterViewModel?
    public var rowModels: [IRowModel]
    
    public init(headerViewModel: IHeaderFooterViewModel? = nil,
         footerViewModel: IHeaderFooterViewModel? = nil,
         rowModels: [IRowModel]
    ) {
        self.headerViewModel = headerViewModel
        self.footerViewModel = footerViewModel
        self.rowModels = rowModels
    }
}

public class HomeRowModel: IRowModel {
    public func getBundleCellViewIdentifier() -> String { return "" }
    public var rowCellDidSelectAction: ((IRowModel?) -> ())?
    public var index: IndexPath?
    public weak var tableView: UITableView?
    public var rowCellwillDisplay: ((UITableViewCell) -> ())?
    
    public func updateCellView(
        animationType: UITableView.RowAnimation = .none
    ) {
        if let index = index,
           let tableView = tableView
        {
            DispatchQueue.main.async {
                tableView.reloadRows(
                    at: [index],
                    with: animationType)
            }
        }
    }
}

public protocol ScrollTableViewDelegate: class {
    func scrollTableViewWith(y: CGFloat,
                             finish: Bool)
}

public class HomeAdapter: BaseAdapter<HomeSectionModel> {
    public var reachedBottom: (() -> Void)?
    public weak var delegateForScroll: ScrollTableViewDelegate?
    
    public override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = super.tableView(
            tableView,
            cellForRowAt: indexPath
        )
        if let section = models?[safe: indexPath.section] {
            let rowModels = section.rowModels
            if let rowModel = rowModels[safe: indexPath.row] as? HomeRowModel {
                rowModel.index = indexPath
                rowModel.tableView = tableView
            }
            
            if section.rowModels.count > indexPath.row {
                // 滑到倒數第5筆就loading看看有無下一頁
                if indexPath.row == section.rowModels.count - 5 {
                    reachedBottom?()
                }
            }
        }
        return cell
    }
    
    public override func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        delegateForScroll?.scrollTableViewWith(
            y: scrollView.contentOffset.y,
            finish: false
        )
    }
    
    public override func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        if !decelerate {
            delegateForScroll?.scrollTableViewWith(
                y: scrollView.contentOffset.y,
                finish: true
            )
        }
    }
    
    public override func updateData(
        models: [HomeSectionModel]
    ) {
        if models.count > 0 {
            // 給index方便用
            for sectionCount in 0...models.count - 1 {
                if let models = models[safe: sectionCount],
                   models.rowModels.count > 0 {
                    for rowCount in 0...models.rowModels.count - 1 {
                        if let rowModel = models.rowModels[safe: rowCount] as? HomeRowModel {
                            rowModel.index = IndexPath(row: rowCount,
                                                       section: sectionCount)
                            rowModel.tableView = tableView
                        }
                    }
                }
            }
            self.models = models
        }
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}
