//
//  Offset_ScrollView.swift
//  FantasyUIExample
//
//  Created by Liseami on 2021/11/20.
//

import SwiftUI
import FantasyUI

struct Offset_ScrollView: View {
    @State private var offset : CGFloat = 0
    var body: some View {
        PF_OffsetScrollView(offset: $offset) {
            VStack {
                Text("\(offset)")
            }
        }
    }
}

struct Offset_ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        Offset_ScrollView()
    }
}
