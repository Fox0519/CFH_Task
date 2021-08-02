//
//  SimpleStackCellTests.swift
//  CFHTaskTests
//
//  Created by fox on 2021/8/2.
//

import XCTest
@testable import CFHTask

class SimpleStackCellTests: XCTestCase {
    var simpleStackRowModel: SimpleStackRowModel!
    var simpleStackCell: SimpleStackCell!
    
    override func setUp() {
        super.setUp()
        let title = ["t1", "t2"]
        let detail = ["d1", "d2"]
        var views: [UIView] = []
        for index in 0...title.count - 1 {
            if let view = UINib(
                nibName: String(describing: SimpleTitleDataView.self),
                bundle: nil
            ).instantiate(
                withOwner: nil,
                options: nil
            ).first as? SimpleTitleDataView {
                view.setup(
                    title: title[safe: index] ?? "",
                    detail: detail[safe: index] ?? ""
                )
                views.append(view)
            }
        }
        simpleStackRowModel = SimpleStackRowModel(stackViews: views)
        if let cell = UINib(
            nibName: String(describing: SimpleStackCell.self),
            bundle: nil
        ).instantiate(
            withOwner: nil,
            options: nil
        ).first as? SimpleStackCell {
            simpleStackCell = cell
        }
    }
    
    override func tearDown() {
        simpleStackRowModel = nil
        simpleStackCell = nil
        super.tearDown()
    }
    
    func testSetupView() {
        simpleStackCell.setupView(rowModel: simpleStackRowModel)
        XCTAssertEqual(simpleStackCell.withTopDistance.constant,
                       simpleStackRowModel.withTopDistance
        )
        XCTAssertEqual(simpleStackCell.withRightDistance.constant,
                       simpleStackRowModel.withRightDistance
        )
        XCTAssertEqual(simpleStackCell.withBottomDistance.constant,
                       simpleStackRowModel.withBottomDistance
        )
        XCTAssertEqual(simpleStackCell.withLeftDistance.constant,
                       simpleStackRowModel.withLeftDistance
        )
        XCTAssertEqual(simpleStackCell.stackView.subviews,
                       simpleStackRowModel.stackViews
        )
    }
}
