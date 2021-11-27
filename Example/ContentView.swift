//
//  ContentView.swift
//  FantasyUIExample
//
//  Created by Liseami on 2021/11/20.
//

import SwiftUI


struct  ContentView: View {
    @State private var PF_Half_Sheet : Bool = false
    @State private var System_Sheet : Bool = false
    @State private var PF_Navilink : Bool  = false
    @State private var PF_FullScreen : Bool  = false
    @State private var ShowOffset_ScrollView : Bool = false
    @State private var PF_Navilink_PF_Navilink : Bool = false
    @State private var offset : CGFloat = 0
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    Button("PF_Half_Sheet"){
                        withAnimation(.spring()){
                            PF_Half_Sheet.toggle()
                        }
                    }
                    Button("System_Sheet"){
                        System_Sheet.toggle()
                    }
                }header: {
                    Text("Sheet")
                }
                
                Section {
                    Button("PF_Navilink"){
                        PF_Navilink.toggle()
                    }
                    Button("PF_FullScreen"){
                        PF_FullScreen.toggle()
                    }
                }header: {
                    Text("System_Tool")
                }
                
                Section {
                    VStack(alignment: .leading,spacing: 12){
                        Button("Offset_ScrollView"){
                            ShowOffset_ScrollView.toggle()
                        }
                    }
                }header: {
                    Text("Offset_ScrollView\r可捕获下拉距离的ScrollView")
                }
                
                Section {
                    VStack(alignment: .leading,spacing: 12){
                        Button("Offset_ScrollView"){
                            ShowOffset_ScrollView.toggle()
                        }
                    }
                }header: {
                    Text("PF_")
                }
                
                
            }
            .listStyle(.insetGrouped )
            .navigationTitle("PrueFantasy")
            .PF_SystemSheet(isPresented: $System_Sheet, onDismiss: {
                
            }, content: {
                Text("$System_Sheet")
            })
            .PF_Sheet(isPresented: $PF_Half_Sheet, content: {
                VStack{
                    ForEach(0..<12){ index in
                        HStack{
                            Spacer()
                            Text("$PF_Half_Sheet")
                            Spacer()
                        }
                    }
                }
                .padding()
            }, background: {
                Color.red
            })
            .PF_Navilink(isPresented: $PF_Navilink, content: {
                VStack(spacing:12){
                    ForEach(0..<12){index in
                        Button {
                            PF_Navilink_PF_Navilink = true
                        } label: {
                            Text("PF_Navilink \(index)")
                        }
                    }
                }
                .PF_Navilink(isPresented: $PF_Navilink_PF_Navilink) {
                    Text("$PF_Navilink_PF_Navilink")
                }
            })
            .PF_Navilink(isPresented: $ShowOffset_ScrollView, content: {
                PF_OffsetScrollView(offset: $offset,topPadding:false) {
                    Text("\(offset)").padding(.top,100)
                }
            })
            .PF_FullScreen(isPresented: $PF_FullScreen) {
                
            } content: {
                Button("PF_FullScreen"){
                    PF_FullScreen.toggle()
                }
            }
        }
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
