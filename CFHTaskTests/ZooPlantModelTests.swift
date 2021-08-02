//
//  ZooPlantModelTests.swift
//  CFHTaskTests
//
//  Created by fox on 2021/8/1.
//

import XCTest
@testable import CFHTask

class ZooPlantModelTests: XCTestCase {
    var zooPlantModel: ZooPlantModel!
    let data = [
        "F_Name_Ch": "植物的中文名",
        "F_Location": "世界各處",
        "F_Feature": "特徵很厲害",
        "F_Pic01_URL": "xxxx/url"
    ]
    
    override func setUp() {
        super.setUp()
        zooPlantModel = ZooPlantModel()
        if let jsonData = try? JSONSerialization.data(
            withJSONObject: data,
            options: .prettyPrinted) {
            zooPlantModel = try? JSONDecoder().decode( ZooPlantModel.self, from: jsonData)
        }
    }
    
    override func tearDown() {
        zooPlantModel = nil
        super.tearDown()
    }
    
    func testZooPlantModelDecodeSuccess() {
        XCTAssertNoThrow(try? JSONSerialization.data(
                            withJSONObject: data,
                            options: .prettyPrinted))
        if let jsonData = try?
            JSONSerialization.data(
                withJSONObject: data,
                options: .prettyPrinted
            ) {
            XCTAssertNoThrow(try? JSONDecoder().decode(
                                    ZooPlantModel.self,
                                    from: jsonData)
            )
        }
        
        if let jsonData = try?
            JSONSerialization.data(
                withJSONObject: data,
                options: .prettyPrinted) {
            let model = try? JSONDecoder().decode(
                ZooPlantModel.self,
                from: jsonData
            )
            XCTAssertEqual(
                model?.name,
                zooPlantModel.name
            )
            XCTAssertEqual(
                model?.location,
                zooPlantModel.location
            )
            XCTAssertEqual(
                model?.feature,
                zooPlantModel.feature
            )
            XCTAssertEqual(
                model?.picUrl,
                zooPlantModel.picUrl
            )
        }
    }
    
    func testZooPlantModelDecodeFailJSON() {
        let failData = [
            "F_Name_Ch_x": "植物的中文名",
            "F_Location_x": "世界各處",
            "F_Feature_x": "特徵很厲害",
            "F_Pic01_URL_x": "xxxx/url"
        ]
        XCTAssertNoThrow(try? JSONSerialization.data(
                            withJSONObject: failData,
                            options: .prettyPrinted))
        if let jsonData = try?
            JSONSerialization.data(
                withJSONObject: failData,
                options: .prettyPrinted
            ) {
            XCTAssertNoThrow(try? JSONDecoder().decode(
                                    ZooPlantModel.self,
                                    from: jsonData)
            )
        }
        if let jsonData = try?
            JSONSerialization.data(
                withJSONObject: failData,
                options: .prettyPrinted) {
            let model = try? JSONDecoder().decode(
                ZooPlantModel.self,
                from: jsonData
            )
            XCTAssertNotEqual(
                model?.name,
                zooPlantModel.name
            )
            XCTAssertNotEqual(
                model?.location,
                zooPlantModel.location
            )
            XCTAssertNotEqual(
                model?.feature,
                zooPlantModel.feature
            )
            XCTAssertNotEqual(
                model?.picUrl,
                zooPlantModel.picUrl
            )
        }
    }
}
