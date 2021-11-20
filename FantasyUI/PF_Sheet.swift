//
//  PFSheet.swift
//  Cashmix
//
//  Created by Liseami on 2021/11/19.
//

import SwiftUI

struct PF_SheetView<Content,Back> : View where Content : View ,Back:View{
    @Environment(\.colorScheme) var colorScheme
    let content : ()->Content
    let background : ()->Back
    @GestureState var offset : CGFloat = 0
    @State private var bodyHeight : CGFloat = 0
    @Binding var show : Bool
    var capsulebarColor : Color = .black
    
    init(isPresented : Binding<Bool>,content:@escaping ()-> Content,background:@escaping ()-> Back)
    {
        self.content = content
        self.background = background
        _show = isPresented
    }
    
    @ViewBuilder
    var body: some View {
        
        
        //手势
        let gesture = DragGesture(minimumDistance: 4, coordinateSpace: CoordinateSpace.global)
            .updating($offset, body: { value, out , transition in
    out = value.translation.height
})
            .onEnded({ value in
    if value.translation.height > (bodyHeight * 0.2){
        madasoft()
        withAnimation(.spring()){
            show = false
        }
    }
})
        
        
        
            
            VStack{
                    Spacer()
                    capsulebar
                    self.content()
                    .background(back)
                    .offset(y:offset > 0 ? offset : 0)
                    .gesture(gesture)
               
            }
            .padding(.horizontal,6)
            .padding(.bottom,-12)
        
          
            
            
            
      
    }
    @ViewBuilder
    var back : some View{
        GeometryReader(content: { proxy in
            background()
                .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                .onAppear {
          self.bodyHeight = proxy.size.height
                }
        })
    }
    
    var capsulebar : some View {
        
        Capsule(style: .continuous)
            .frame(width: SW * 0.1, height: 4)
            .foregroundColor(capsulebarColor)
            .offset(y:offset > 0 ? offset : 0)
        
    }
    
    
}


extension View{
    func PF_Sheet<Content,Back>(isPresented: Binding<Bool>,  @ViewBuilder content: @escaping () -> Content,@ViewBuilder background: @escaping () -> Back) -> some View where Content : View,Back:View{
            self.overlay(
                    ZStack{
                            Color.black.opacity(0.7).ignoresSafeArea()
                                    .onTapGesture {
                                        withAnimation(){
                                            madasoft()
                                            isPresented.wrappedValue.toggle()
                                        }
                                    }
                                    .transition(.opacity.animation(.spring()))
                                    .ifshow(isPresented.wrappedValue)
                     
                        PF_SheetView(isPresented: isPresented, content: content, background: background)
                            .transition(.move(edge: .bottom).animation(.spring()))
                            .animation(.spring())
                            .ifshow(isPresented.wrappedValue )
                    }
                )
    }
}
