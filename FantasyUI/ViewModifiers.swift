//
//  ViewMod.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//

import Foundation
import SwiftUI


extension View {
    //逻辑显示
    func ifshow(_ show : Bool) -> some View {
        modifier(ifshowView(show: show))
    }
}


struct ifshowView : ViewModifier {
    var show : Bool
    func body(content: Content) -> some View {
        Group{
            if show {
                content
            }
        }
    }
}


