//
//  NetworkPlugin.swift
//  fenJianXiao_iOS
//
//  Created by liangze on 2019/12/17.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation
import Moya

/// 通用网络插件
public class CustomNetworkLoggerPlugin: PluginType, NetworkStatusProtocol {
    /// 开始请求字典
    private static var startDates: [String: Date] = [:]

    public init() {}

    /// 即将发送请求
    public func willSend(_: RequestType, target: TargetType) {
        #if DEBUG
            // 设置当前时间
            CustomNetworkLoggerPlugin.startDates[String(describing: target)] = Date()
        #endif
    }

    /// 收到请求时
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
            guard let startDate = CustomNetworkLoggerPlugin.startDates[String(describing: target)] else { return }
            // 获取当前时间与开始时间差（秒数）
            let requestDate = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970

            print("🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢\(target.path)🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢")
            if let url = result.rawReponse?.request?.url?.absoluteString {
                print("URL : \(url)")
            } else {
                print("URL : \(target.baseURL)\(target.path)")
            }
            print("请求方式：\(target.method.rawValue)")
            print("请求时间 : \(String(format: "%.3f", requestDate))s")
            if let token = target.headers?["token"] {
                let start = String(token.prefix(7))
                let end = String(token.suffix(7))
                let tokenD = ["token": start + "..." + end]
                print("请求头 : \(tokenD)")
            }
            if let request = result.rawReponse?.request {
                switch target.task {
                case .requestPlain, .uploadMultipart: break
                case let .requestParameters(parameters, _), let .uploadCompositeMultipart(_, parameters):
                    print("请求参数 : ", parameters)
                default:
                    if let requestBody = request.httpBody {
                        let decrypt = requestBody.parameterString()
                        print("请求参数 : \(decrypt)")
                    }
                }
            }

            switch result {
            case let .success(response):
                if let data = String(data: response.data, encoding: .utf8) {
                    let message = (try? response.map(String.self, atKeyPath: "message")) ?? ""
                    let code = (try? response.map(String.self, atKeyPath: "code")) ?? ""
                    print("""
                    HttpCode : \(response.response?.statusCode ?? -1)
                    status :\(code)
                    message : \(message)
                    """)
                    print("响应数据：\n \(data))")
                } else {
                    let message = (try? response.map(String.self, atKeyPath: "error_description")) ?? ""
                    print("message: \(message)")
                }

            case let .failure(error):

                print("请求错误：\(error)")
            }

            // 删除完成的请求开始时间
            CustomNetworkLoggerPlugin.startDates.removeValue(forKey: String(describing: target))
            print("🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺\(target.path)🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺")
        #endif
    }
}

private extension Data {
    func parameterString() -> String {
        guard let json = try? JSONSerialization.jsonObject(with: self),
              let value = json as? [String: Any]
        else {
            return ""
        }
        return "\(value)"
    }
}

// public func lzprint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    #if DEBUG
//    print(items, separator: separator, terminator: terminator)
//    #endif
// }

/// 网络状态协议
protocol NetworkStatusProtocol {
    func isReachable() -> Bool
}

extension NetworkStatusProtocol {
    /// 返回一个布尔值,用于实时监测网络状态
    func isReachable() -> Bool {
        var res = false
        let netManager = NetworkReachabilityManager()
        if netManager?.status == .reachable(.ethernetOrWiFi) || netManager?.status == .reachable(.cellular) { res = true }
        return res
    }
}
