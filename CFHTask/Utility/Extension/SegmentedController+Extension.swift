//
//  SegmentedController+Extension.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

extension UISegmentedControl {
    public func replaceSegments(
        segments: Array<String>
    ) {
        removeAllSegments()
        for segment in segments {
            insertSegment(
                withTitle: segment,
                at: self.numberOfSegments,
                animated: false
            )
        }
    }
}
