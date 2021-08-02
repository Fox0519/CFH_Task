//
//  ScrollNavigationViewTests.swift
//  CFHTaskTests
//
//  Created by fox on 2021/8/2.
//

import XCTest
@testable import CFHTask

class ScrollNavigationViewTests: XCTestCase {
    var scrollNavigationView: ScrollNavigationView!
    let inputHeight: CGFloat = 100
    
    override func setUp() {
        super.setUp()
        scrollNavigationView = ScrollNavigationView(
            frame: .zero,
            viewModel: ScrollNavigationViewModel(
                mainTitle: "我是大Title",
                secondTitle: "我是小Title",
                height: inputHeight
            )
        )
    }
    
    override func tearDown() {
        scrollNavigationView = nil
        super.tearDown()
    }
    
    func testInitCheckValuesSuccess() {
        // separate: 為傳入height的1/3Height
        XCTAssertEqual(scrollNavigationView.checkValues.separate,
                       inputHeight / 3
        )
        // topSeparate: 為傳入height的1/3 * 2(topView高度) / 3
        XCTAssertEqual(scrollNavigationView.checkValues.topSeparate,
                       ((inputHeight / 3) * 2) / 3
        )
        // bottomSeparate: 為傳入height的1/3 (bottomView高度) / 2
        XCTAssertEqual(scrollNavigationView.checkValues.bottomSeparate,
                       (inputHeight / 3) / 2
        )
        // screenWidth: 為螢幕的寬
        XCTAssertEqual(scrollNavigationView.checkValues.screenWidth,
                       UIScreen.main.bounds.size.width
        )
    }
    
    func testInitSuccess() {
        XCTAssertNotNil(scrollNavigationView.viewModel)
        XCTAssertNotNil(scrollNavigationView.topView)
        XCTAssertNotNil(scrollNavigationView.bottomView)
        XCTAssertNotNil(scrollNavigationView.checkValues)
    }
}
