//
//  PublicStruct.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/23.
//

import Foundation
import SwiftUI


//MARK: 自定义圆角
public struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

