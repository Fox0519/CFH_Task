//
//  UILabel+Extension.swift
//  CFHTask
//
//  Created by fox on 2021/8/1.
//

import UIKit

extension UILabel {
    public func setupDefaultUI(
        text: String,
        textColor: UIColor,
        font: UIFont
    ) {
        self.text = text
        self.textColor = textColor
        self.font = font
    }
}
