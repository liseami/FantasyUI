//
//  PublicStruct.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/23.
//

import Foundation
import SwiftUI


//MARK: 自定义圆角
public struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    public init(radius:CGFloat,corners:UIRectCorner){
        self.radius = radius
        self.corners = corners
    }
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


//MARK: 图标
public struct ICON: View {
    var sysname : String?
    var name : String = ""
    var fcolor : Color = .black
    var size : CGFloat = 24
    var fontWeight : Font.Weight = .regular
    var action : (()-> Void)?
    
    public init(sysname : String,fcolor : Color = .black ,size : CGFloat = 16,fontWeight: Font.Weight = .regular ,action : (()-> Void)? = nil ){
        self.sysname = sysname
        self.fcolor = fcolor
        self.size = size
        self.fontWeight = fontWeight
        self.action = action
    }
    public init(name : String,fcolor : Color = .black ,size : CGFloat = 24,action : (()-> Void)? = nil ){
        self.name = name
        self.fcolor = fcolor
        self.size = size
        self.action = action
    }

    public var body: some View {
        
        Button {
            if let action = action {
                action()
            }
        } label: {
            Group{
                if sysname == nil {
                    Image(name)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(fcolor)
                        .scaledToFill()
                        .frame(width: size, height: size,alignment: .center)
                }else{
                    Image(systemName: sysname!)
                        .renderingMode(.template)
                        .foregroundColor(fcolor)
                        .font(Font.system(size: size,weight: fontWeight))
                        .frame(width: size, height: size,alignment: .center)
                }
            }
            .frame(alignment: .center)
        }
        .disabled(action == nil)
    }
}



public enum NaviTopStyle {
    case large
    case inline
    case none
}




//MARK: 一个异步加载的图像
public struct PF_AsyncImage : View{
    
    var imageData : Data?
    var uiimage : UIImage?
    @State var image : Image?
    
    public init (_ imageData : Data?){
        self.imageData = imageData
    }
    public init (_ uiimage : UIImage?){
        self.uiimage = uiimage
    }
    
    public var body: some View{
        
        Group{
            if let image = image {
                image
                    .resizable()
                    .transition(.opacity)
            }else if let iamge  = uiimage{
                    Image(uiImage: iamge)
                        .resizable()
                        .transition(.opacity)
            }else{
                Color.gray.opacity(0.33)
                    .onAppear {
                            dataToImage { image in
                                withAnimation(.spring()){
                                    self.image = image
                                }
                            }
                    }
            }
        }
    }
    func dataToImage(completion: @escaping (Image)->()){
        DispatchQueue.global().async {
            if let imageData = imageData {
                if let uiimage = UIImage(data: imageData){
                    let image = Image(uiImage: uiimage)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
}


//MARK: MenuBtn
public struct PF_MenuBtn : View {
    let text : String
    let sysname : String?
    let name: String?
    let action : ()-> Void
    
    public init(text:String ,sysname : String , action : @escaping ()->()){
        self.text = text
        self.sysname = sysname
        self.action = action
        self.name = nil
    }
    public init(text:String ,name : String , action : @escaping ()->()){
        self.text = text
        self.name = name
        self.action = action
        self.sysname = nil
    }
    public var body: some View {
        return Button {
            action()
        } label: {
            Label {
                Text(text)
            } icon: {
                ICON(sysname: sysname ?? "")
                    .ifshow(sysname != nil)
                ICON(name: name ?? "" )
                    .ifshow(name != nil)
            }
            
        }
    }
}




public struct PF_alert: View {
    
    
    public enum AlertStyle {
        case cancel
        case success
        case wrong
    }
    
    
    @Binding var show : Bool
    @GestureState var offset : CGFloat = 0
    
    
    var style : AlertStyle = .cancel
    var text : String = "PF_Alert"
    var color : Color = .black
    var textcolor : Color = .black
   
   
    
    public init(text: String ,color : Color , textcolor : Color = .black , show : Binding<Bool> ,style:AlertStyle = .cancel ){
        _show = show
        self.text = text
        self.color = color
        
        self.style  = style
    }
    
    public var body: some View {
        
        Alert
            .onAppear(perform: {
                switch style {
                case .cancel:
                     madasoft()
                case .success:
                    madaSuccess()
                case .wrong:
                    madaWarning()
                }
            })
            .onDisappear(perform: {
                madasoft()
            })
            .ifshow(show, animation: .spring(), transition: .offset(x: 0, y: SH * -0.3))
            .onChange(of: show) { newValue in
                if newValue {DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    if newValue {show = false}
                }}
            }
    }
    
    @ViewBuilder
    
    var Alert : some View {
        
        let gesture = DragGesture(minimumDistance: 12, coordinateSpace: .global)
            .updating($offset) { value, out, transition in
                let height = value.translation.height
                out = height
            }
            .onEnded { value in
                show.toggle()
            }
        
            HStack(spacing:12){
                ICON(sysname: "checkmark.circle.fill", fcolor: color, size: 16, action: {
                    show.toggle()})
                    .ifshow(style == .success)
                ICON(sysname: "exclamationmark.circle.fill", fcolor: color, size: 16, action: {
                    show.toggle()})
                    .ifshow(style == .wrong)
            Text(LocalizedStringKey(text))
                .font(.system(size: 17, weight: .light, design: .rounded))
                .foregroundColor(textcolor)
            Spacer()
                ICON(sysname: "xmark", fcolor: color, size: 16, action: {
                    self.show = false
                })
                    .ifshow(style == .cancel)
            }
        .padding()
        .background(
            ZStack{
                Color.white
                color.opacity(0.1)}
           )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(lineWidth: 0.6).foregroundColor(color))
        .shadow(color: color.opacity(0.1), radius: 12, x: 0, y:3)
        .shadow(color: Color.black.opacity(0.03), radius: 24 , x: 0, y: 6)
        .padding()
        .gesture(gesture)
        .offset(y:offset)
        .simultaneousGesture(TapGesture().onEnded({ _ in
            self.show = false
        }))
       
    }
}


public struct ClearFullScreenBackView: UIViewRepresentable {

    public func makeUIView(context: Context) -> UIView {
       let view = UIView()
       DispatchQueue.main.async {
           //superview = BackgroundCleanerView
           //superview = UIHostingView
           let superView = view.superview?.superview
           superView?.backgroundColor = .clear
           superView?.layer.shadowColor = UIColor.clear.cgColor
           superView?.layer.shadowRadius = 0
           superView?.layer.shadowOpacity = 0
       }
       return view
   }
   
    public func updateUIView(_ uiView: UIView, context: Context) {}
}
