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
    
    
    @Binding var offset : CGFloat
    @State private var can_refresh : Bool = false
    @State private var refreshing : Bool = false
    
    var topPadding : Bool = true
    let content : ()-> Body
   
    public init(offset:Binding<CGFloat>, topPadding : Bool = true, content : @escaping ()-> Body) {
        _offset = offset 
        self.topPadding = topPadding
        self.content = content
    }
    
    
    // MARK: - Body
    @ViewBuilder
    public var body: some View{
        
        Group{
            if topPadding {
                ScrollView(.vertical, showsIndicators: false)  {
                    VStack(spacing:0){
                        offsetDetector
                        self.content()
                            .padding(.top,44 + TopSafeArea)
                    }
                    Spacer().frame(width: 0, height: SW)
                }
                .ignoresSafeArea()
            }
            else
            {
                ScrollView(.vertical, showsIndicators: false)  {
                    VStack(spacing:0){
                        offsetDetector
                        self.content()
                    }
                    
                    Spacer().frame(width: 0, height: SW)
                }
                .ignoresSafeArea()
            }
        }
        .onChange(of: offset) { newValue in
        //向下拉动超过50，可以执行刷新
            if offset > 50 && !can_refresh {
                can_refresh = true
            }
         
            guard offset >= 50 else {return}
            
            
        }
      
        
 
        
        
    }
    
    @ViewBuilder
    var offsetDetector : some View{
        // Header View...
        GeometryReader{ proxy -> AnyView in
            // Sticky Header...
            let minY = proxy.frame(in: .global).minY
            DispatchQueue.main.async {
                self.offset = minY
            }
            return AnyView(
                    Divider()
                    .opacity(0)
            )
        }
        .frame(height: 0)
        .zIndex(1)
    }
}



struct PF_OffsetScrollView_Preview : View{
    @State private var offset : CGFloat = 0
    
    var body: some View{
        
        PF_OffsetScrollView(offset: $offset, content: {
            VStack{
                Text("\(offset)")
                ForEach(0 ..< 5) { item in
                    Color.gray
                        .frame(width: SW, height: 44)
                }
            }
          
        })
        
        

    }
}
struct PF_OffsetScrollView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        PF_OffsetScrollView_Preview()
    }
}
