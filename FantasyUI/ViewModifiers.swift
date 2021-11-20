//
//  ViewMod.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//


import SwiftUI

//动画防抖
struct PF_AnimationModifier: ViewModifier {
    let animationed: Animation?
    @State private var canAnimation = false
    func body(content: Content) -> some View {
        content
            .animation(canAnimation ? animationed : nil)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    canAnimation = true
                }
            }
    }
}


//MARK: 调整按钮位置至屏幕角落
public struct PF_MovotoModifier : ViewModifier {
    public enum edge {
        case centerLeading
        case centerTrailing
        case topCenter
        case bottomCenter
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }
    var WhereMoveTo : edge
    
    public func body(content: Content) -> some View {
        switch WhereMoveTo {
        case .centerLeading :
            HStack(alignment: .center) {content;Spacer()}
        case .centerTrailing:
            HStack(alignment: .center) {Spacer();content}
        case .topCenter:
            VStack{content;Spacer()}
        case .bottomCenter:
            VStack{Spacer();content}
        case .topLeading:
            VStack{HStack{content;Spacer()};Spacer()}
        case .topTrailing:
            VStack{HStack{Spacer();content};Spacer()}
        case .bottomLeading:
            VStack{Spacer();HStack{content;Spacer()}}
        case .bottomTrailing:
            VStack{Spacer();HStack{Spacer();content}}
        }
    }
}


///暗黑模式预览
struct Preview : ViewModifier{
    func body(content: Content) -> some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                content
            }
            .navigationBarTitleDisplayMode(.inline)
        }    .preferredColorScheme(.dark)
        
    }
}
