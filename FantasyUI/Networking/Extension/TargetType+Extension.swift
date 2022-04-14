//
//  NetworkConfig.swift
//  fenJianXiao_iOS
//
//  Created by ash on 2019/11/25.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation
import Moya

public typealias HTTPRequestMethod = Moya.Method

public protocol FantasyTargetType: TargetType {
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var group: String { get }
}
