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
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


///图标
public struct ICON: View {
    var sysname : String?
    var name : String = ""
    var fcolor : Color = .black
    var size : CGFloat = 24
    var fontWeight : Font.Weight = .regular
    var action : (()-> Void)?
    
    public init(sysname : String,fcolor : Color = .black ,size : CGFloat = 24,fontWeight: Font.Weight = .regular ,action : (()-> Void)? = nil ){
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




//一个异步加载的图像
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


//MenuBtn
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
