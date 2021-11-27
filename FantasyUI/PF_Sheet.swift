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
    var backcornerRadius : CGFloat = 32
    
    init(isPresented : Binding<Bool>,capsulebarColor : Color = .black , backcornerRadius : CGFloat = 32, content:@escaping ()-> Content,background:@escaping ()-> Back)
    {
        _show = isPresented
        self.content = content
        self.background = background
        self.capsulebarColor = capsulebarColor
        self.backcornerRadius = backcornerRadius
        
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
                content()
                    .background(back)
            }
            .offset(y:offset > 0 ? offset : 0)
            .gesture(gesture)
        }
    }

    
    @ViewBuilder
    var back : some View{
        GeometryReader(content: { proxy in
            background()
                .frame(width: SW)
                .clipShape(RoundedCorner(radius: backcornerRadius, corners: [.topLeft,.topRight]))
                .ignoresSafeArea()
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
    
    public func PF_Sheet<Content,Back>(isPresented: Binding<Bool>, capsulebarColor : Color = .black,backcornerRadius:CGFloat = 32, @ViewBuilder content: @escaping () -> Content,@ViewBuilder background: @escaping () -> Back) -> some View where Content : View,Back:View{

        return  self.overlay(
<<<<<<< HEAD
=======
            
>>>>>>> 600737b (commit)
                    Color.black.opacity(0.7).ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(){
                                madasoft()
                                isPresented.wrappedValue = false
                            }
                        }
                        .ifshow(isPresented.wrappedValue,animation: .spring(), transition: .opacity)
                
            )
            .overlay(        //抽屉
                PF_SheetView(isPresented: isPresented,capsulebarColor: capsulebarColor, backcornerRadius: backcornerRadius, content: content, background: background)
                    .ifshow(isPresented.wrappedValue, animation: .linear(duration: 0.5), transition: .move(edge: .bottom).animation(.linear(duration: 0.5))),alignment: .bottom)
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
        .PF_Sheet(isPresented: $show, capsulebarColor: .black) {
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
            
        } background: {
            Color.red
        }
        
    }
}

struct PF_SheetViewExample_Previews: PreviewProvider {
    static var previews: some View {
        PF_SheetViewExample()
    }
}
