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


///图标
public struct ICON: View {
    var sysname : String?
    var name : String = ""
    var fcolor : Color = .black
    var size : CGFloat = 24
    var fontWeight : Font.Weight = .regular
    var action : (()-> Void)?
    
    public init(sysname : String,fcolor : Color = .black ,size : CGFloat = 24,fontWeight: Font.Weight = .regular ,action : (()-> Void)? = nil ){
        self.sysname = sysname
        self.fcolor = fcolor
        self.size = size
        self.fontWeight = fontWeight
        self.action = action
    }
    public init(name : String,fcolor : Color = .black ,size : CGFloat = 24,action : (()-> Void)? = nil ){
        self.name = name
        self.fcolor = fcolor
        self.size = size
        self.action = action
    }

    public var body: some View {
        
        Button {
            if let action = action {
                action()
            }
        } label: {
            Group{
                if sysname == nil {
                    Image(name)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFill()
                        .frame(width: size, height: size,alignment: .center)
                }else{
                    Image(systemName: sysname!)
                        .font(Font.system(size: size,weight: fontWeight))
                        .frame(width: size, height: size,alignment: .center)
                }
            }
            .foregroundColor(fcolor)
            .frame(alignment: .center)
        }
        .disabled(action == nil)
    }
}



public enum NaviTopStyle {
    case large
    case inline
    case none
}
