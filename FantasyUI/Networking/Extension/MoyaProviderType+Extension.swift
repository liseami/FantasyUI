//
//  MoyaProviderTypeExtension.swift
//  SwiftComponentsDemo
//
//  Created by liangze on 2020/9/4.
//  Copyright © 2020 liangze. All rights reserved.
//

import Foundation
import KakaJSON
import Moya

public extension MoyaProviderType {
    @discardableResult
    func requestObject<T: Convertible>(_ target: Target,
                                       modeType _: T.Type,
                                       atKeyPath keyPath: String? = nil,
                                       callbackQueue: DispatchQueue? = .none,
                                       progress: Moya.ProgressBlock? = .none,
                                       completion: @escaping (MoyaResult, T?) -> Void) -> Cancellable
    {
        return request(target, callbackQueue: callbackQueue, progress: progress) { r in
            let m = r.rawReponse?.mapObject(T.self, atKeyPath: keyPath)
            if r.code == StatusCode.tokenexpired || r.message == "暂未登录或token已经过期" {
                NotificationCenter.default.post(name: Notification.Name("tokenFail"), object: nil)
            }

            completion(r, m)
        }
    }

    @discardableResult
    func requestArray<T: Convertible>(_ target: Target,
                                      modeType _: T.Type,
                                      atKeyPath keyPath: String? = nil,
                                      callbackQueue: DispatchQueue? = .none,
                                      progress: Moya.ProgressBlock? = .none,
                                      completion: @escaping (MoyaResult, [T]?) -> Void) -> Cancellable
    {
        return request(target, callbackQueue: callbackQueue, progress: progress) { r in
            let ms = r.rawReponse?.mapArray(T.self, atKeyPath: keyPath)
            if r.code == StatusCode.tokenexpired || r.message == "暂未登录或token已经过期" {
                NotificationCenter.default.post(name: Notification.Name("tokenFail"), object: nil)
            }
            completion(r, ms)
        }
    }
}
