//
//  FindApiDefault.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

public protocol FindApiDefaultProtocol {
    var domainName : String { get }
    var rid : String { get }
    var pageSize : Int { get }
}

public enum FindApiDefault: FindApiDefaultProtocol {
    /**
     ## 用對照的方式取的他的DefaultValue
     */
    public var domainName: String { return "" }
    public var rid : String { return "" }
    public var pageSize : Int { return 0 }
    
    /// 台北市資料大平台 若之後有其他api可集中管理
    public enum TaipeiBigData {
        /**
         - Remark:
         動物園_植物資料
         
         - Attention:
         Class is ZooPlantModel
         
         */
        case zooPlantList
    }
}

fileprivate struct ApiDomainNames {
    public static let taipeiOpenData = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire"
}
fileprivate struct ApiRids {
    public static let zooPlantList = "f18de02f-b6c9-47c0-8cda-50efad621c14"
}
fileprivate struct ApiPageSizes {
    public static let zooPlantList = 20
}

extension FindApiDefault.TaipeiBigData: FindApiDefaultProtocol {
    public var domainName: String {
        switch self {
        case .zooPlantList:
            return ApiDomainNames.taipeiOpenData
        }
    }
    
    public var pageSize: Int {
        switch self {
        case .zooPlantList:
            return ApiPageSizes.zooPlantList
        }
    }
    
    public var rid: String {
        switch self {
        case .zooPlantList:
            return ApiRids.zooPlantList
        }
    }
}
