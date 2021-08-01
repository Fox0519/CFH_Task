//
//  SimpleStackCell.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

public class SimpleStackRowModel: HomeRowModel {
    public override func getBundleCellViewIdentifier() -> String {
        return SimpleStackCell.cellIdentifier()
    }
    public var withTopDistance: CGFloat = 30
    public var withRightDistance: CGFloat = 24
    public var withBottomDistance: CGFloat = 30
    public var withLeftDistance: CGFloat = 24
    public var stackSpacing: CGFloat = 5
    public var stackViews: [UIView] = []
    
    public init(withTopDistance: CGFloat = 30,
         withRightDistance: CGFloat = 24,
         withBottomDistance: CGFloat = 30,
         withLeftDistance: CGFloat = 24,
         titleWithStackDistance: CGFloat = 4,
         stackSpacing: CGFloat = 5,
         stackViews: [UIView] = [],
         rowAction:((IRowModel?) -> ())? = nil) {
        super.init()
        self.withTopDistance = withTopDistance
        self.withRightDistance = withRightDistance
        self.withBottomDistance = withBottomDistance
        self.withLeftDistance = withLeftDistance
        self.stackSpacing = stackSpacing
        self.stackViews = stackViews
        if let action = rowAction {
            rowCellDidSelectAction = action
        }
    }
}

class SimpleStackCell: UITableViewCell {
    @IBOutlet private weak var withTopDistance: NSLayoutConstraint!
    @IBOutlet private weak var withRightDistance: NSLayoutConstraint!
    @IBOutlet private weak var withBottomDistance: NSLayoutConstraint!
    @IBOutlet private weak var withLeftDistance: NSLayoutConstraint!
    @IBOutlet private weak var stackView: UIStackView!
}

extension SimpleStackCell: ICellViewBase {
    public func setupView(rowModel: IRowModel) {
        guard let rowModel = rowModel as? SimpleStackRowModel else { return }
        withTopDistance.constant = rowModel.withTopDistance
        withRightDistance.constant = rowModel.withRightDistance
        withBottomDistance.constant = rowModel.withBottomDistance
        withLeftDistance.constant = rowModel.withLeftDistance
        stackView.spacing = rowModel.stackSpacing
        // 先清空再重長
        stackView.cleanThenSetup(items: rowModel.stackViews)
    }
}
