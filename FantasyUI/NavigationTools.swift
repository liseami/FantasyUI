//
//  FantasyUI.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/19.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

@available(iOS 13.0, tvOS 13.0, macOS 10.15.0, *)
extension View {
    public func inject<SomeView>(_ view: SomeView) -> some View where SomeView: View {
        return background(view)
    }
}

@available(iOS 13.0, tvOS 13.0, macOS 10.15.0, *)
extension View {
    
    ///封装系统Navilink
     public func PF_Navilink<Link>(isPresented: Binding<Bool>, content: @escaping () -> Link ) -> some View where Link : View{
         return inject(
            ZStack{
                Group{
                    NavigationLink(isActive: isPresented) {
                        content()
                    } label: {
                        EmptyView()
                    }
                    //解决自动弹出Bug
                    NavigationLink {
                        EmptyView()
                    } label: {
                        EmptyView()
                    }
                }
            }
        )
        
    }
    
    ///封装系统Sheet
    ///解决iOS14.4出现的单一响应问题：一个View多个Sheet只有最后一个响应
     public func PF_SystemSheet<Content>(isPresented: Binding<Bool>, onDismiss: (()->Void)?,  content: @escaping () -> Content) -> some View where Content : View{
         
        return inject(Text("金诚所至，金石为开")
                        .opacity(0)
                        .sheet(isPresented: isPresented, onDismiss: onDismiss, content: {
                            content()
                        }))
    }
    
    ///封装系统FullScreen
    ///解决iOS14.4出现的单一响应问题：一个View多个Sheet只有最后一个响应
     public func PF_FullScreen<Content>(isPresented: Binding<Bool>,  onDismiss: (()->Void)?, content: @escaping () -> Content) -> some View where Content : View{
         return inject(Text("金诚所至，金石为开")
                        .opacity(0)
                        .fullScreenCover(isPresented: isPresented, onDismiss: onDismiss, content: {
                            content()
                        }))
        
    }
    
}

