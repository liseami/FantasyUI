//
//  OffsetScrollView.swift
//  Cashmix
//
//  Created by Liseami on 2021/11/18.
//

import SwiftUI
import UIKit

//可以测算offset的ScrollowView
public struct PF_OffsetScrollView<Body> : View  where Body : View{
    
    
    
    @State private var min : CGFloat = 0
    @State private var canrefresh : Bool = false
    @State private var refreshing : Bool = false
    @State private var showshift : Bool = false
    @State private var showarrow : Bool = true
    @State private var showErrorTextPlaceHolder : Bool = false
    @Binding var offset : CGFloat
    @State private var delay1sOver : Bool = false
    @State private var refreshingenable : Bool = false
    
    public enum refreshResult{
        case success
        case error
    }
    
    //刷新动作
    var refreshAction : (_ endrefresh : @escaping (_ result : refreshResult)->()) -> () = {endrefresh in }
    
    let content : ()-> Body
    
    public init(offset:Binding<CGFloat>,refreshingenable : Bool = false, refreshAction : @escaping (_ endrefresh : @escaping (_ result : refreshResult)->()) -> () = {endrefresh in } ,content : @escaping ()-> Body) {
        _offset = offset
        self.refreshingenable = refreshingenable
        self.refreshAction = refreshAction
        self.content = content
        
    }
    
    
    // MARK: - Body
    @ViewBuilder
    public var body: some View{
        
        
        ScrollView(.vertical, showsIndicators: false)  {
            VStack(spacing:0){
          
                //延迟1.2秒再进入视图，下拉时才出现，上滑时隐藏
                if delay1sOver && refreshingenable {
                    
                    offsetDetector
                    refreshArea
                        .ifshow(offset >= 0)
                    
                    VStack(spacing:6){
                        Text("现在无法刷新")
                            .font(.system(size: 17, weight: .heavy, design: .monospaced))
                            .foregroundColor(.black)
                        Text("点击重试")
                            .font(.system(size: 13, weight: .light, design: .monospaced))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .onTapGesture {
                        withAnimation(.spring()){
                            showarrow = false
                            refreshing = true
                        }
                        //测试延迟
                        //                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        refreshAction { result in
                            refreshResultHandle(result)
                        }
                        //                    }
                    }
                    .animation(.spring(), value: showErrorTextPlaceHolder)
                    .ifshow(showErrorTextPlaceHolder && !refreshing)
                    .zIndex(2)
                }
                
                self.content()
                    .zIndex(1)
            }
            Spacer().frame(width: 0, height: SW)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                delay1sOver = true
            }
        }
        
        
        
        
        
        
        
        
        
    }
    
    @ViewBuilder
    var offsetDetector : some View{
        // Header View...
        GeometryReader{ proxy -> AnyView in
            // Sticky Header...
            let minY = proxy.frame(in: .global).minY
            DispatchQueue.main.async {
                self.offset = minY - min
            }
            return AnyView(
                Spacer()
                    .opacity(0)
                    .onAppear {
                        let minY = proxy.frame(in: .global).minY
                        self.min = minY
                    }
            )
        }
        .frame(height: 0)
        .zIndex(1)
    }
    
    
    
    var refreshArea : some View {
        GeometryReader { geo in
            //需要拉动的距离
            Rectangle()
                .fill(Color.clear)
                .frame(height: refreshing ? 44 : offset < 0 ? 0 : offset)
                .overlay(
                    
                    ZStack{
                        ICON(sysname: "arrow.down",fcolor: .black, size: 24)
                            .offset( y: -12 + (offset / 44) * 12)
                            .animation(.easeIn(duration: 0.2),value: canrefresh)
                            .rotationEffect(Angle(degrees: canrefresh ? 180 : 0))
                            .opacity(offset > 0 ? 1 : 0)
                            .ifshow(showarrow)
                        
                        ProgressView()
                            .ifshow(!showarrow)
                            .ifshow(canrefresh || refreshing)
                    }
                    
                )
            
        }
        .frame(height: refreshing ? 44 : offset < 0 ? 0 : offset)
        /// 拉够44的距离，松手时可以刷新
        .onChange(of: offset) { newValue in
            guard !self.canrefresh else {return}
            if offset > 44 {
                withAnimation(.spring()){
                    self.canrefresh = true
                    madasoft()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showarrow = false
                    }
                }
            }
        }
        //松手时执行刷新
        .onChange(of: offset) { newValue in
            if newValue < 44 && canrefresh && !refreshing {
                withAnimation(.spring()){
                    refreshing = true
                }
                refreshAction { result in
                    refreshResultHandle(result)
                }
            }
        }
    }
    
    func refreshResultHandle(_ result : refreshResult){
        
        //刷新动作结束时的回调函数
        withAnimation(.spring()){
            refreshing = false
            canrefresh = false
            showarrow = true
            showErrorTextPlaceHolder = (result != .success)
        }
        
    }
}



struct PF_OffsetScrollView_Preview : View{
    @State private var offset : CGFloat = 0
    
    var body: some View{
        
        PF_OffsetScrollView(offset: $offset) { endrefresh in
            endrefresh(.success)
        } content: {
            VStack(spacing:0){
                Color.gray
                    .frame(height:SH)
                    .overlay(
                        VStack{
                            Text("\(offset)")
                            Text("CONTEN")
                        }
                    )
            }
        }
        
        
        
        
        
        
        
        
    }
}
struct PF_OffsetScrollView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        PF_OffsetScrollView_Preview()
    }
}


