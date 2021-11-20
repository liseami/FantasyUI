//
//  FantasyUI.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/19.
//

import SwiftUI

extension View{
    
    ///封装系统Navilink
    public func PF_Navilink<Link>(isPresented: Binding<Bool>,  @ViewBuilder content: @escaping () -> Link ) -> some View where Link : View{
        let result = self.background(
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
        return result
    }
    
    ///封装系统Sheet
    ///解决iOS14.4出现的单一响应问题：一个View多个Sheet只有最后一个响应
    public func PF_SystemSheet<Content>(isPresented: Binding<Bool>, onDismiss: (()->Void)?, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View{
        let result = self.background(
            Text("金诚所至，金石为开")
                .opacity(0)
                .sheet(isPresented: isPresented, onDismiss: onDismiss, content: {
                    content()
                })
        )
        return result
    }
    
    ///封装系统FullScreen
    ///解决iOS14.4出现的单一响应问题：一个View多个Sheet只有最后一个响应
    public func PF_FullScreen<Content>(isPresented: Binding<Bool>,  onDismiss: (()->Void)?, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View{
        let result = self.background(
            Text("金诚所至，金石为开")
                .opacity(0)
                .fullScreenCover(isPresented: isPresented, onDismiss: onDismiss, content: {
                    content()
                })
        )
        return result
    }
    
}
