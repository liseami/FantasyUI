//
//  ViewExtensions.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//


import Foundation
import SwiftUI
import Combine


extension View {
    
    public func PF_Leading() -> some View {
      return  self
             .frame(maxWidth:.infinity,alignment: .leading)
    }
   
    //MARK: 添加顶部模糊
    public func PF_Navitop<BACK,TOP>(style : NaviTopStyle ,showDivider : Bool = true, @ViewBuilder backgroundView: @escaping () -> BACK, @ViewBuilder TopCenterView: @escaping (() -> TOP)) -> some View where BACK : View ,TOP :View{
            let height = style == .large ? TopSafeArea + 44 :  TopSafeArea
         return self
            .overlay(
                backgroundView()
                        .frame( height: height)
                        .overlay(Divider().opacity(0.5).ifshow(showDivider),alignment: .bottom)
                        .overlay(TopCenterView().padding(.bottom,6),alignment: .bottom)
                        .MoveTo(.topCenter)
                        .ignoresSafeArea()
                        .ifshow(style != .none , animation: .spring(), transition: .move(edge: .top).animation(.spring()))
            )
           
    }
    
    //MARK: 逻辑显示
    public func ifshow(_ show : Bool,  animation: Animation? = nil , transition: AnyTransition? = nil ) -> some View {
        Group{
            if show
                {
                       self
                    .animation(animation, value: show)
                            .transition(transition ?? .opacity)
                }
        }
    }
    
    
    
    //MARK: 添加时间接收器
    public func PF_Timer(timer:Publishers.Autoconnect<Timer.TimerPublisher>,showStep:Binding<Int>,limit:Int) -> some View {
        let result = self.background(
            Text("精诚所至，金石为开。")
                .opacity(0)
                .onReceive(timer) { _ in
                    guard showStep.wrappedValue < limit else {return}
                    withAnimation(.spring()){
                        showStep.wrappedValue += 1
                    }
                }
                .ifshow(showStep.wrappedValue < limit)
        )
        return result
    }
    
    
    //MARK: 动画防抖
    public func PF_Animation(_ animation: Animation? = .default) -> some View {
        modifier(PF_AnimationModifier(animationed: animation))
    }
    
    
    //MARK: 内阴影
    public func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2))
        let finalY = CGFloat(sin(angle.radians - .pi / 2))
        return self
            .overlay(
                shape
                    .stroke(color, lineWidth: width)
                    .offset(x: finalX * width * 0.6, y: finalY * width * 0.6)
                    .blur(radius: blur)
                    .mask(shape)
            )
    }
    
    //MARK: 移动
    public func MoveTo( _ edge : PF_MovotoModifier.edge ) -> some View{
        self.modifier(PF_MovotoModifier(WhereMoveTo: edge))
        
    }
    
    //MARK: 暗黑模式预览
    public func isPreview() -> some View{
        self.modifier(Preview())
    }
}


