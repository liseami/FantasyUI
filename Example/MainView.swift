//
//  MainView.swift
//  Example
//
//  Created by 赵翔宇 on 2021/12/18.
//

import SwiftUI

struct MainView: View {
    @State private var tabindex : Int = 0
    var body: some View {
        
            TabView(selection: $tabindex) {
                UIDemoList().tag(0)
                    .tabItem {
                        ICON(sysname: "scribble.variable")
                        Text("UIDemo")
                    }
                NetworkFlow()
                    .tag(1)
                    .tabItem {
                        ICON(sysname: "network")
                        Text("NetWork")
                    }
            }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
