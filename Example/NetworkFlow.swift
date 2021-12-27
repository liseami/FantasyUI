//
//  SwiftUIView.swift
//  Example
//
//  Created by 赵翔宇 on 2021/12/18.
//

import SwiftUI

struct NetworkFlow: View {
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationBarTitle(Text("NetworkFlow"))
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkFlow()
    }
}
