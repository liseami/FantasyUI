//
//  PFSheet.swift
//  Cashmix
//
//  Created by Liseami on 2021/11/19.
//

import SwiftUI

struct PF_SheetView<Content> : View where Content : View{
    @Environment(\.colorScheme) var colorScheme
    let content : ()->Content

    
    @GestureState var offset : CGFloat = 0
    @State private var bodyHeight : CGFloat = 0
    @Binding var show : Bool
    var capsulebarColor : Color = .black
    var backcornerRadius : CGFloat = 32
    var backColor : Color = .white
    
    init(isPresented : Binding<Bool>,capsulebarColor : Color = .black , backcornerRadius : CGFloat = 32, backColor : Color, content:@escaping ()-> Content)
    {
        _show = isPresented
        self.content = content
        self.capsulebarColor = capsulebarColor
        self.backcornerRadius = backcornerRadius
        self.backColor = backColor
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
        
        VStack
        {
            Group {
                capsulebar
                VStack(spacing:0){
                    Rectangle()
                        .fill(backColor)
                        .clipShape(RoundedCorner(radius: backcornerRadius, corners: [.topLeft,.topRight]))
                        .frame( height: backcornerRadius, alignment: .center)
                    content()
                        .background(backColor.ignoresSafeArea())
                        .ignoresSafeArea()
                        .background(back)
                }
               
            }
            .offset(y:offset > 0 ? offset : 0)
            .gesture(gesture)
        }
    }

    
    @ViewBuilder
    var back : some View{
        GeometryReader(content: { proxy in
            Color.clear
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
    
    public func PF_Sheet<Content>(isPresented: Binding<Bool>, capsulebarColor : Color = .black,backcornerRadius:CGFloat = 32,backColor : Color, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View{

        return  self.overlay(
            Color.black.opacity(0.618).ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(){
                                madasoft()
                                isPresented.wrappedValue = false
                            }
                        }
                        .ifshow(isPresented.wrappedValue,animation: .spring(), transition: .opacity)
                
            )
            .overlay(        //抽屉
                PF_SheetView(isPresented: isPresented,capsulebarColor: capsulebarColor, backcornerRadius: backcornerRadius,backColor: backColor, content: content)
                
                    .ifshow(isPresented.wrappedValue, animation: .spring(), transition: .offset(x: 0, y: SH)
                           )
                
                ,alignment: .bottom)
    }
}


struct PF_SheetViewExample: View {
    @State private var show : Bool = false
    var body: some View {
        
        ZStack{
            NavigationView{
                Color.yellow
                    .navigationTitle("The Big Blue")
            }
            Button {
                withAnimation(){
                        show = true
                }
            } label: {
                Text("show Sheet")
            }
        }
        .PF_Sheet(isPresented: $show, capsulebarColor: .black,backColor: .black) {
            VStack{
                ForEach(0..<12){ index in
                    HStack{
                        Spacer()
                        Text("Hello,world")
                        Spacer()
                    }
                    .padding()
                }
            }
            .background(Color.red)
            
        }
        
    }
}

struct PF_SheetViewExample_Previews: PreviewProvider {
    static var previews: some View {
        PF_SheetViewExample()
    }
}
