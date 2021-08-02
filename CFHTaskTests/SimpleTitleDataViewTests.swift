//
//  SimpleTitleDataViewTests.swift
//  CFHTaskTests
//
//  Created by fox on 2021/8/2.
//

import XCTest
@testable import CFHTask

class SimpleTitleDataViewTests: XCTestCase {
    var simpleTitleDataView: SimpleTitleDataView!
    let titleText = "title"
    let detailText = "detail"
    let color: UIColor = .black
    let font: UIFont = .systemFont(ofSize: 16)
    
    override func setUp() {
        super.setUp()
        if let view = UINib(
            nibName: String(describing: SimpleTitleDataView.self),
            bundle: nil
        ).instantiate(
            withOwner: nil,
            options: nil
        ).first as? SimpleTitleDataView {
            simpleTitleDataView = view
        }
    }
    
    override func tearDown() {
        simpleTitleDataView = nil
        super.tearDown()
    }
    
    func testSetupDefaultUI() {
        simpleTitleDataView.titleLabel.setupDefaultUI(
            text: titleText,
            textColor: color,
            font: font
        )
        simpleTitleDataView.detailLabel.setupDefaultUI(
            text: detailText,
            textColor: color,
            font: font
        )
        XCTAssertNotNil(simpleTitleDataView.titleLabel)
        XCTAssertNotNil(simpleTitleDataView.titleLabel.text)
        XCTAssertEqual(simpleTitleDataView.titleLabel.text,
                       titleText
        )
        XCTAssertEqual(simpleTitleDataView.detailLabel.text,
                       detailText
        )
    }
    
    func testSetupSuccess() {
        simpleTitleDataView.setup(title: titleText, detail: detailText)
        XCTAssertNotNil(simpleTitleDataView)
        XCTAssertNotNil(simpleTitleDataView.titleLabel)
        XCTAssertNotNil(simpleTitleDataView.titleLabel.text)
        XCTAssertEqual(simpleTitleDataView.titleLabel.text,
                       titleText
        )
        XCTAssertEqual(simpleTitleDataView.detailLabel.text,
                       detailText
        )
    }
}
