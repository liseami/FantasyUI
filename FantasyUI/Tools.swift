//
//  Tools.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//

import Foundation
import UIKit



//MARK:马达震动反馈//////////////////////////////////////////
//马达震动.成功信号
func madaSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

//马达震动.警告信号
func madaWarning() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
}

//马达震动.错误信号
func madaError() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}
//马达震动反馈//////////////////////////////////////////

func madasoft() {
    let generator = UIImpactFeedbackGenerator(style: .soft)
    generator.impactOccurred()
}
//马达震动反馈//////////////////////////////////////////

//关闭键盘
public func closeKeyboard(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
}
