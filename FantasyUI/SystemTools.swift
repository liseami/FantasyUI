//
//  Tools.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//

import Foundation
import UIKit
import SwiftUI




//MARK:马达震动反馈//////////////////////////////////////////
//马达震动.成功信号
public func madaSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

//马达震动.警告信号
public func madaWarning() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
}

//马达震动.错误信号
public func madaError() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}
//马达震动反馈//////////////////////////////////////////

public func madasoft() {
    let generator = UIImpactFeedbackGenerator(style: .soft)
    generator.impactOccurred()
}
//马达震动反馈//////////////////////////////////////////

//关闭键盘
public func closeKeyboard(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
}


//展示系统ShareSheet
public func showShareAppSheet(shareitems : [Any]){
    if let topController = UIApplication.topViewController() {
        let activityController = UIActivityViewController(activityItems: shareitems, applicationActivities: nil)
        topController.present(activityController, animated: true, completion: nil)
    }
}



public func getDominantColorsByUIImageData(_ data : Data,completion : @escaping (Color) -> ()){
    DispatchQueue.global().async {
        if let uiimage = UIImage(data: data ){
            do {
                let background = try uiimage.averageColor()
                var color = Color.clear
                if #available(iOS 15.0, *) {
                    color = Color(uiColor: background)
                } else {
                    let hex = background.hex
                    color = Color(hex: hex)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    completion(color)
                })
                
            } catch {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    completion(Color.black)
                })
            }
        }
    }
}


public func getDominantColorsByUIImage(_ uiimage : UIImage,completion : @escaping (Color) -> ()){
    DispatchQueue.global().async {
        
            do {
                let background = try uiimage.averageColor()
                var color = Color.clear
                if #available(iOS 15.0, *) {
                    color = Color(uiColor: background)
                } else {
                    let hex = background.hex
                    color = Color(hex: hex)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    completion(color)
                })
            } catch {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    completion(Color.black)
                })
            }
    }
}
