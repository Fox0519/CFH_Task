//
//  ApiServerTests.swift
//  CFHTaskTests
//
//  Created by fox on 2021/8/2.
//

import XCTest
@testable import CFHTask

class ApiServerTests: XCTestCase {
    var apiServer: ApiServer!
    
    override func setUp() {
        super.setUp()
        apiServer = ApiServer.shared
    }
    
    override func tearDown() {
        apiServer = nil
        super.tearDown()
    }
    
    func testGetDefaultParamSuccess() {
        let param = apiServer.getDefaultParam(api: .zooPlantList)
        XCTAssertEqual(
            param["rid"] as! String,
            FindApiDefault.TaipeiBigData.zooPlantList.rid
        )
    }
    
    func testGetDefaultParamFail() {
        // a3e2b221-75e0-45c1-8f97-75acbd43d613 = 台北市動物園動物資料rid
        let checkRid = "a3e2b221-75e0-45c1-8f97-75acbd43d613"
        let param = apiServer.getDefaultParam(api: .zooPlantList)
        XCTAssertNotEqual(
            param["rid"] as! String,
            checkRid
        )
    }
    
    func testFetchZooPlantListSuccess() {
        let e = expectation(description: "Alamofire")
        apiServer.fetchZooPlantList(
            parameters: apiServer.getDefaultParam(
                api: .zooPlantList
            )) { (jsonModel, error) in
            XCTAssertTrue(error == nil)
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchZooPlantListFail() {
        let e = expectation(description: "Alamofire")
        apiServer.fetchZooPlantList(
            parameters: [:]
        ) { (jsonModel, error) in
            XCTAssertFalse(error == nil)
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
