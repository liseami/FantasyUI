//
//  Tools.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//

import Foundation
import SwiftUI
import UIKit

/*
 马达震动反馈
 */
// 马达震动.成功信号
public func madaSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

// 马达震动.警告信号
public func madaWarning() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
}

// 马达震动.错误信号
public func madaError() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}

public func mada(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
}

/*
 关闭键盘
 */
public func closeKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

/*
 系统分享sheet
 */
public func showShareAppSheet(shareitems: [Any]) {
    if let topController = UIApplication.topViewController() {
        let activityController = UIActivityViewController(activityItems: shareitems, applicationActivities: nil)
        topController.present(activityController, animated: true, completion: nil)
    }
}

/*
 提取图片主色
 */
public func getDominantColorsByUIImageData(_ data: Data, completion: @escaping (Color) -> Void) {
    DispatchQueue.global().async {
        if let uiimage = UIImage(data: data) {
            do {
                let background = try uiimage.averageColor()
                var color = Color.clear
                color = Color(uiColor: background)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    completion(color)
                }

            } catch {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    completion(Color.black)
                }
            }
        }
    }
}

/*
 提取图片主色
 */
public func getDominantColorsByUIImage(_ uiimage: UIImage, completion: @escaping (Color) -> Void) {
    DispatchQueue.global().async {
        do {
            let background = try uiimage.averageColor()
            var color = Color.clear
            color = Color(uiColor: background)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion(color)
            }
        } catch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion(Color.black)
            }
        }
    }
}
