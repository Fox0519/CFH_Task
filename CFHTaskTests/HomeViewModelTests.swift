//
//  HomeViewModelTests.swift
//  CFHTaskTests
//
//  Created by fox on 2021/8/2.
//

import XCTest
@testable import CFHTask

class HomeViewModelTests: XCTestCase {
    var homeViewModel: HomeViewModel!
    let tableView = UITableView()
    let scrollNavigationViewHeight: CGFloat = 100

    override func setUp() {
        super.setUp()
        homeViewModel = HomeViewModel(tableView:tableView, scrollNavigationViewHeight: scrollNavigationViewHeight)
    }
    
    override func tearDown() {
        homeViewModel = nil
        super.tearDown()
    }
    
    func testSetupAdapter() {
        homeViewModel.setupAdapter(tableView: tableView)
        XCTAssertNotNil(homeViewModel.adapter)
    }
    
    func testApiReportCheckApiPage() {
        homeViewModel.whenApiReportCheckApiPage(success: true, pageNum: 1, newDataCount: 20)
        XCTAssertEqual(homeViewModel.apiPage,
                       2
        )
        homeViewModel.whenApiReportCheckApiPage(success: false, pageNum: 1, newDataCount: 20)
        XCTAssertEqual(homeViewModel.apiPage,
                       -1
        )
        homeViewModel.whenApiReportCheckApiPage(success: true, pageNum: 1, newDataCount: 5)
        XCTAssertEqual(homeViewModel.apiPage,
                       -1
        )
    }
    
    func testGetSimpleStackRowModel() {
        let checkModels = homeViewModel.getSimpleStackRowModel(models: [])
        XCTAssertEqual(checkModels.count,
                       [].count
        )
    }
    
    func testCreatSimpleView() {
        let dataModel = SimpleTitleDataModel(title: "title", detail: "detail")
        let checkView = homeViewModel.creatSimpleView(data: dataModel)
        XCTAssertNotNil(checkView)
    }
    
    func testCheckHeights() {
        let height: CGFloat = 100
        let y: CGFloat = 50
        let checkHeight = HomeViewModel.CheckHeights(height: height, y: y)
        /// min: 為傳入height的 1 / 3
        XCTAssertEqual(checkHeight.min,
                       height / 3
        )
        /// max: 為傳入height的 1 / 3 * 2 (= / 1.5)
        XCTAssertEqual(checkHeight.max,
                       height / 1.5
        )
        /// half: 為傳入height的一半
        XCTAssertEqual(checkHeight.half,
                       height / 2
        )
        /// final: 為傳入height扣除y之值
        XCTAssertEqual(checkHeight.final,
                       height - y
        )
        /// halfMax: 為傳入的max的一半
        XCTAssertEqual(checkHeight.halfMax,
                       checkHeight.max / 2
        )
    }
    
    func testScrollTableViewWith() {
        let height: CGFloat = 100
        let y: CGFloat = 50
        let checkHeight = HomeViewModel.CheckHeights(height: height, y: y)
        /// min: 為傳入height的 1 / 3
        XCTAssertEqual(checkHeight.min,
                       height / 3
        )
        /// max: 為傳入height的 1 / 3 * 2 (= / 1.5)
        XCTAssertEqual(checkHeight.max,
                       height / 1.5
        )
        /// half: 為傳入height的一半
        XCTAssertEqual(checkHeight.half,
                       height / 2
        )
        /// final: 為傳入height扣除y之值
        XCTAssertEqual(checkHeight.final,
                       height - y
        )
        /// halfMax: 為傳入的max的一半
        XCTAssertEqual(checkHeight.halfMax,
                       checkHeight.max / 2
        )
    }
}
