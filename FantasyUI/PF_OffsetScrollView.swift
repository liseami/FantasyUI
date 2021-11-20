//
//  OffsetScrollView.swift
//  Cashmix
//
//  Created by Liseami on 2021/11/18.
//

import SwiftUI

//可以测算offset的ScrollowView
struct PF_OffsetScrollView<Body> : View  where Body : View{
    
    @Binding var offset : CGFloat
    let content : ()-> Body
    
    
    init(offset:Binding<CGFloat>,content : @escaping ()-> Body) {
        _offset = offset
        self.content = content
    }
    // MARK: - Body
    @ViewBuilder
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false)  {
            offsetDetector
            
            self.content()
                .padding(.top,TopSafeArea + 44)
            
            Spacer().frame(width: 0, height: SW)
        }
        .ignoresSafeArea()
        
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
                ZStack{
                    Divider().opacity(0)
                        .offset(y:(TopSafeArea))
                }
            )
        }
        .frame(height: 0)
        .zIndex(1)
    }
}


struct PF_OffsetScrollView_OffsetScrollView_Previews: PreviewProvider {
    static var previews: some View {
        
        PF_OffsetScrollView(offset: .constant(32), content: {
            ForEach(0 ..< 5) { item in
                Text("23")
            }
        })
    }
}
