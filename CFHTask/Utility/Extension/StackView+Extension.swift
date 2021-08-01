//
//  StackView+Extension.swift
//  CFHTask
//
//  Created by fox on 2021/7/30.
//

import UIKit

extension UIStackView {
    public func cleanThenSetup(
        items: [UIView]
    ) {
        for view in subviews {
            view.removeFromSuperview()
        }
        for view in items {
            addArrangedSubview(view)
        }
    }
}
