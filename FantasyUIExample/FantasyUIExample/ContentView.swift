//
//  ContentView.swift
//  FantasyUIExample
//
//  Created by Liseami on 2021/11/20.
//

import SwiftUI
import FantasyUI

struct  ContentView: View {
    @State private var PF_Half_Sheet : Bool = false
    @State private var System_Sheet : Bool = false
    @State private var PF_Navilink : Bool  = false
    @State private var PF_FullScreen : Bool  = false
    @State private var ShowOffset_ScrollView : Bool = false
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    Button("PF_Half_Sheet"){
                        PF_Half_Sheet.toggle()
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
                        Text("可捕获下拉距离的ScrollView")
                        Button("Offset_ScrollView"){
                            ShowOffset_ScrollView.toggle()
                        }
                    }
                    
                    
                }header: {
                    Text("Offset_ScrollView")
                }
                
            }
            .navigationTitle("PrueFantasy")
            .PF_Navilink(isPresented: $ShowOffset_ScrollView, content: {
                Offset_ScrollView()
            })
            .PF_SystemSheet(isPresented: $System_Sheet, onDismiss: {
                
            }, content: {
                Text("$System_Sheet")
            })
            .PF_Sheet(isPresented: $PF_Half_Sheet, capsulebarColor: Color.gray) {
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
            } background: {
                Color.white
            }
            
            .PF_Navilink(isPresented: $PF_Navilink, content: {
                Text("PF_Navilink")
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
