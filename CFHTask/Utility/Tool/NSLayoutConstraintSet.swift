//
//  NSLayoutConstraintSet.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

public class NSLayoutConstraintSet {
    
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?
    public var left: NSLayoutConstraint?
    public var right: NSLayoutConstraint?
    public var centerX: NSLayoutConstraint?
    public var centerY: NSLayoutConstraint?
    public var width: NSLayoutConstraint?
    public var height: NSLayoutConstraint?
    
    public init(top: NSLayoutConstraint? = nil,
                bottom: NSLayoutConstraint? = nil,
                left: NSLayoutConstraint? = nil,
                right: NSLayoutConstraint? = nil,
                centerX: NSLayoutConstraint? = nil,
                centerY: NSLayoutConstraint? = nil,
                width: NSLayoutConstraint? = nil,
                height: NSLayoutConstraint? = nil
    ) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
        self.centerX = centerX
        self.centerY = centerY
        self.width = width
        self.height = height
    }
    
    /// All of the currently configured constraints
    private var availableConstraints: [NSLayoutConstraint] {
        return [top, bottom, left, right,
                centerX, centerY, width, height].compactMap {$0}
    }
    
    /// Activates all of the non-nil constraints
    ///
    /// - Returns: Self
    @discardableResult
    public func activate() -> Self {
        NSLayoutConstraint.activate(availableConstraints)
        return self
    }
    
    /// Deactivates all of the non-nil constraints
    ///
    /// - Returns: Self
    @discardableResult
    public func deactivate() -> Self {
        NSLayoutConstraint.deactivate(availableConstraints)
        return self
    }
}
