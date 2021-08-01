//
//  SimpleTitleDataView.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

public class SimpleTitleDataModel {
    public var title: String
    public var detail: String
    
    public init(title: String,
                detail: String
    ) {
        self.title = title
        self.detail = detail
    }
}

public class SimpleTitleDataView: UIView {
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var detailLabel: UILabel!
    @IBOutlet public weak var betweenDistance: NSLayoutConstraint!
    
    public func setup(title: String,
               detail: String,
               distance: CGFloat = 16,
               font: UIFont = .systemFont(ofSize: 14),
               titleColor: UIColor = .brown,
               detailColor: UIColor = .black,
               onlyOneLine: Bool = false
    ) {
        titleLabel.setupDefaultUI(
            text: title,
            textColor: titleColor,
            font: font
        )
        detailLabel.setupDefaultUI(
            text: detail,
            textColor: detailColor,
            font: font
        )
        betweenDistance.constant = distance
        detailLabel.numberOfLines = onlyOneLine ? 1 : 0
    }
}
