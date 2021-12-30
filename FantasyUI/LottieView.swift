//
//  LottieView.swift
//  TimeMachine (iOS)
//
//  Created by Liseami on 2021/9/27.
//


import UIKit
import SwiftUI
import Lottie

public struct LottieView: UIViewRepresentable {
    
    //声明文件名作为Lottie变量以便于重复使用
    var lottieFliesName : String
    var loopMode: LottieLoopMode
    var speed : CGFloat = 1
    
    public typealias UIViewType = UIView
    //装载洛丽塔动画
    // ——————————————————————————————————————————————————————————————————————————
    public func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let animation = Animation.named(lottieFliesName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        //播放模式
        animationView.loopMode = loopMode
        //播放速度
        animationView.animationSpeed = speed
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
        
    }
    //    —————————————————————————————————————————————————————————————————————
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}


