//
//  ApiTest.swift
//  Cashmix
//
//  Created by 赵翔宇 on 2021/12/18.
//


//Api
enum LogoutApi: PFApiType {
    case setOut
    
    
    var path: String {
        "/system/logout"
    }
    
    var method: HTTPRequestMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        nil
    }
    
}
 

//Request
public func Networktest() {
    Networking.request(LogoutApi.setOut) { result in
        
    }
}



//Model
struct networkStruct : Convertible {
    
    var productId = "" //:"2c9780827c30630d017c306c65600000",
    var productName = ""//:"网站后台权限管理系统",
    var productLang = ""//:"Java",
    var productPrice = ""// ":0.01,
    var productOriginalPrice = ""//:0.01,
    var status = ""//:0,
    var cstCreate = ""
    var cstCreateTimestamp = ""
    var createUserId = ""
    var authorNickname = ""
    var authorHeadImgUrl = ""
    var countBrowses = "" // 浏览个数
    var bought = ""
}
