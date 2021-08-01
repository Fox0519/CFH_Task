//
//  APIServer.swift
//  CFHTask
//
//  Created by fox on 2021/7/28.
//

import Alamofire

open class ApiServer {
    public static let shared = ApiServer()
    
    /// 生成一個有基本rid的param
    public func getDefaultParam(
        api: FindApiDefault.TaipeiBigData
    ) -> [String: Any] {
        return ["rid": api.rid]
    }
    
    /// 抓取台北市動物園_植物公開資料用的param
    public func paramZooPlantList(
        page: Int,
        pageSize: Int = FindApiDefault.TaipeiBigData.zooPlantList.pageSize
    ) -> [String: Any] {
        var param = getDefaultParam(api: .zooPlantList)
        param["limit"] = pageSize
        let offset = (page - 1) * pageSize
        param["offset"] = offset > 0 ? offset : 0
        
        return param
    }

    /// 抓取台北市動物園_植物公開資料
    func fetchZooPlantList(
        parameters: Parameters,
        completion: @escaping (_ result: [ZooPlantModel]?,
                               _ error: Error?) -> Void)
    {
        AF.request(
            FindApiDefault.TaipeiBigData.zooPlantList.domainName,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default
        ).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                // convert data to dictionary array
                if let value = value as? [String: Any],
                   let result = value["result"] as? [String: Any],
                   let results = result["results"] as? [[String: Any]] {
                    var zooPlants: [ZooPlantModel] = []
                    for data in results {
                        if let jsonData = try?
                            JSONSerialization.data(
                                withJSONObject: data,
                                options: .prettyPrinted),
                           let model = try?
                            JSONDecoder().decode(
                                ZooPlantModel.self,
                                from: jsonData) {
                            zooPlants.append(model)
                        }
                    }
                    completion(zooPlants, nil)
                }
            case .failure(let error):
                completion(nil, error.underlyingError)
            }
        })
    }
}
