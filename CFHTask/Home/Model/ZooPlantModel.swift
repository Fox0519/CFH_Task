//
//  ZooPlantModel.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

/// 台北市動物園植物資料
public struct ZooPlantModel: Codable {
    
    /**
     中文名
     - note
     參數: F_Name_Ch
     - note
     預設: ""
     */
    public let name: String
    
    /**
     所在位置
     - note
     參數: F_Location
     - note
     預設: ""
     */
    public let location: String
    
    /**
     形態特徵
     - note
     參數: F_Feature
     - note
     預設: ""
     */
    public let feature: String
    
    /**
     照片
     - note
     參數: F_Pic01_URL
     - note
     預設: ""
     */
    public let picUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "F_Name_Ch"
        case location = "F_Location"
        case feature = "F_Feature"
        case picUrl = "F_Pic01_URL"
    }
    
    private init(form decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? values.decodeIfPresent(
                    String.self,
                    forKey: .name)) ?? ""
        
        location = (try? values.decodeIfPresent(
                        String.self,
                        forKey: .location)) ?? ""
        
        feature = (try? values.decodeIfPresent(
                    String.self,
                    forKey: .feature)) ?? ""
        
        picUrl = (try? values.decodeIfPresent(
                    String.self,
                    forKey: .picUrl)) ?? ""
    }
}
