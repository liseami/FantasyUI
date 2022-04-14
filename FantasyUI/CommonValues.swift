//
//  CommonValues.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//

import SwiftUI
import UIKit

public let SW = UIScreen.main.bounds.width
public let SH = UIScreen.main.bounds.height
public let AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
public let AppBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

public enum Device {
    // MARK: 当前设备类型 iphone ipad mac

    public enum Devicetype {
        case iphone, ipad, mac
    }

    public static var deviceType: Devicetype {
        #if os(macOS)
            return .mac
        #else
            if UIDevice.current.userInterfaceIdiom == .pad {
                return .ipad
            } else {
                return .iphone
            }
        #endif
    }
}
