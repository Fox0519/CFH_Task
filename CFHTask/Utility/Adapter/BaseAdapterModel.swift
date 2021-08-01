//
//  BaseAdapterModel.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

// Header View Protocol
public protocol IHeaderModel {
    var headerViewModel: IHeaderFooterViewModel? { get set }
}

// Footer View Protocol
public protocol IFooterModel {
    var footerViewModel: IHeaderFooterViewModel? { get set }
}

// Section Model
public protocol ISectionModel{
    var rowModels: [IRowModel] { get set }
}

// Header Footer View Model
public protocol IHeaderFooterViewModel {
    func getReuseHeaderFooterIdentifier() -> String
}

// Cell Row Model
public protocol IRowModel {
    func getBundleCellViewIdentifier()->String
}

// Cell View
public protocol ICellViewBase{
    func setupView(rowModel: IRowModel)
}

// The ITableEvent Protocol
public typealias TableComplete = (IndexPath, UITableViewCell) -> Void
public protocol ITableEvent {
    var didSelect: TableComplete? { get }
}
