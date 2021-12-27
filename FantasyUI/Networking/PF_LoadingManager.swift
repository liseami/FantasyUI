//
//  PF_LoadingManager.swift
//  FantasyUI
//
//  Created by 赵翔宇 on 2021/12/25.
//

import SwiftUI

struct PF_LoadingManager<Content> : View where Content : View{
    
    let content : ()->Content
   
    
    init(content:@escaping ()-> Content)
    {
        self.content = content
    }
    
    @ViewBuilder
    var body: some View {
        
      Text("12313")

    }
}
        

struct PF_LoadingManager_Previews: PreviewProvider {
    static var previews: some View {
        PF_LoadingManager {
            Text("Hello,world.")
        }
    }
}
