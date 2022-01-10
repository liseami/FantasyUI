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


public struct PF_ShadowMod : ViewModifier{
    
    let color : Color
    var style : Style = .s100
    public enum Style {
        case s100,s200,s300,s400,s500,s600,s700,s800
        
    }
    public func body(content: Content) -> some View {
        switch self.style{
        case .s100 :
            content
                .shadow(color: color.opacity(0.12), radius: 4, x: 0, y: 2)
                .shadow(color: color.opacity(0.08), radius: 4, x: 0, y: 4)
        case .s200:
            content
                .shadow(color: color.opacity(0.12), radius: 6, x: 0, y: 4)
                .shadow(color: color.opacity(0.08), radius: 8, x: 0, y: 8)
        case .s300:
            content
                .shadow(color: color.opacity(0.12), radius: 8, x: 0, y: 6)
                .shadow(color: color.opacity(0.08), radius: 16, x: 0, y: 8)
        case .s400:
            content
                .shadow(color: color.opacity(0.12), radius: 12, x: 0, y: 6)
                .shadow(color: color.opacity(0.08), radius: 24, x: 0, y: 8)
        case .s500:
            content
                .shadow(color: color.opacity(0.12), radius: 14, x: 0, y: 6)
                .shadow(color: color.opacity(0.08), radius: 32, x: 0, y: 10)
        case .s600:
            content
                .shadow(color: color.opacity(0.12), radius: 18, x: 0, y: 8)
                .shadow(color: color.opacity(0.08), radius: 42, x: 0, y: 12)
        case .s700:
            content
                .shadow(color: color.opacity(0.12), radius: 22, x: 0, y: 8)
                .shadow(color: color.opacity(0.08), radius: 64, x: 0, y: 14)
        case .s800:
            content
                .shadow(color: color.opacity(0.12), radius: 22, x: 0, y: 8)
                .shadow(color: color.opacity(0.08), radius: 88, x: 0, y: 18)
        }
       
    }
}

