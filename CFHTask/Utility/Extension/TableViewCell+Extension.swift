//
//  TableViewCell+Extension.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

extension UITableViewCell {
    /// Generated cell identifier derived from class name
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
