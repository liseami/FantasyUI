//
//  ViewExtensions.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//

import Combine
import Foundation
import SwiftUI

public extension View {
    func PF_Leading() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
    }


    // MARK: 逻辑显示
    func ifshow(_ show: Bool) -> some View {
        Group {
            if show {
                self
            }
        }
    }

    // MARK: 添加时间接收器

    func PF_Timer(timer: Publishers.Autoconnect<Timer.TimerPublisher>, showStep: Binding<Int>, limit: Int) -> some View {
        let result = background(
            Text("精诚所至，金石为开。")
                .opacity(0)
                .onReceive(timer) { _ in
                    guard showStep.wrappedValue < limit else { return }
                    withAnimation(.spring()) {
                        showStep.wrappedValue += 1
                    }
                }
                .ifshow(showStep.wrappedValue < limit)
        )
        return result
    }

    // MARK: 动画防抖

    func PF_Animation(_ animation: Animation? = .default) -> some View {
        modifier(PF_AnimationModifier(animationed: animation))
    }

    // MARK: 内阴影

    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2))
        let finalY = CGFloat(sin(angle.radians - .pi / 2))
        return overlay(
            shape
                .stroke(color, lineWidth: width)
                .offset(x: finalX * width * 0.6, y: finalY * width * 0.6)
                .blur(radius: blur)
                .mask(shape)
        )
    }

    // MARK: 移动

    func MoveTo(_ edge: PF_MovotoModifier.edge) -> some View {
        modifier(PF_MovotoModifier(WhereMoveTo: edge))
    }

    // MARK: 暗黑模式预览

    func isPreview() -> some View {
        modifier(Preview())
    }

    // MARK: 阴影

    func PF_Shadow(color: Color = .black, style: PF_ShadowMod.Style = .s800) -> some View {
        modifier(PF_ShadowMod(color: color, style: style))
    }

    // MARK: 根据设备不同采取不同的行动

    @ViewBuilder func ifDeivceis<T>(_ condition: Bool, transform: (Self) -> T) -> some View where T: View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    @ViewBuilder func ifElse<T: View, V: View>(_ condition: Bool, isTransform: (Self) -> T, elseTransform: (Self) -> V) -> some View {
        if condition {
            isTransform(self)
        } else {
            elseTransform(self)
        }
    }

    // MARK: 警报

    func PF_Alert(text: String, color: Color, textcolor: Color = .black, show: Binding<Bool>, alignment: Alignment = .top, style: PF_alert.AlertStyle = .cancel) -> some View {
        overlay(
            PF_alert(text: text, color: color, textcolor: textcolor, show: show, style: style),
            alignment: alignment
        )
    }
}
