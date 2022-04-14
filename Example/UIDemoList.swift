//
//  ContentView.swift
//  FantasyUIExample
//
//  Created by Liseami on 2021/11/20.
//

import SwiftUI

struct UIDemoList: View {
    @State private var PF_Sheet: Bool = false
    @State private var System_Sheet: Bool = false
    @State private var PF_Navilink: Bool = false
    @State private var PF_FullScreen: Bool = false
    @State private var ShowOffset_ScrollView: Bool = false
    @State private var PF_Navilink_PF_Navilink: Bool = false
    @State private var offset: CGFloat = 0
    @State private var showAlert: Bool = false
    @State private var refundRequestSheet: Bool = false
    @State private var PF_Sheet_SystemSheetStyle: Bool = false

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section {
                        ListRow(name: "PF_Sheet", note: "基础款底部Sheet") {
                            self.PF_Sheet.toggle()
                        }

                        ListRow(name: "PF_Sheet_SystemSheetStyle", note: "模仿iOS后页后仰的Sheet") {
                            self.PF_Sheet_SystemSheetStyle.toggle()
                        }

                        ListRow(name: "System_Sheet") {
                            System_Sheet.toggle()
                        }

                    } header: {
                        Text("Sheet")
                    }

                    Section {
                        ListRow(name: "PF_Navilink") {
                            PF_Navilink.toggle()
                        }

                        ListRow(name: "PF_FullScreen") {
                            PF_FullScreen.toggle()
                        }

                    } header: {
                        Text("System_Tool")
                    }

                    Section("组件") {
                        ListRow(name: "Offset_ScrollView", note: "可捕获下拉距离的ScrollView") {
                            PF_FullScreen.toggle()
                        }

                        Menu {
                            PF_MenuBtn(text: "scribble", sysname: "scribble") {}
                            PF_MenuBtn(text: "square.and.pencil", sysname: "square.and.pencil") {}
                            PF_MenuBtn(text: "rectangle.portrait.and.arrow.right", sysname: "rectangle.portrait.and.arrow.right") {}
                            PF_MenuBtn(text: "square.and.arrow.down.on.square", sysname: "square.and.arrow.down.on.square") {}
                        } label: {
                            Text("PF_MenuBtn")
                                .PF_Leading()
                        }

                        ListRow(name: "PF_Alert") {
                            showAlert.toggle()
                        }
                    }
                }

                .listStyle(.insetGrouped)
                .navigationTitle("FantasyUI")
                .PF_SystemSheet(isPresented: $System_Sheet, onDismiss: {}, content: {
                    Text("$System_Sheet")
                })
                .PF_Sheet(isPresented: $PF_Sheet, capsulebarColor: .gray, backColor: .white, content: {
                    VStack {
                        ForEach(0 ..< 12) { _ in
                            HStack {
                                Spacer()
                                Text("$PF_Sheet")
                                Spacer()
                            }
                        }
                    }
                    .padding()
                })

                .PF_Sheet_SystemSheetStyle(isPresented: $PF_Sheet_SystemSheetStyle, backColor: .white, content: {
                    VStack {
                        ForEach(0 ..< 12) { _ in
                            HStack {
                                Spacer()
                                Text("$PF_Sheet_SystemSheetStyle")
                                Spacer()
                            }
                        }
                    }
                    .padding()
                })
                .PF_Navilink(isPresented: $PF_Navilink, content: {
                    VStack(spacing: 12) {
                        ForEach(0 ..< 12) { index in
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
                    PF_OffsetScrollView(offset: $offset) {
                        Text("\(offset)").padding(.top, 100)
                    }
                })
                .PF_FullScreen(isPresented: $PF_FullScreen) {} content: {
                    VStack(spacing: 32) {
                        Button("PF_FullScreen") {
                            PF_FullScreen.toggle()
                        }
                        Button("PF_Alert") {
                            showAlert.toggle()
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .PF_Alert(text: "FantasyUI通知", color: .black, textcolor: .blue, show: $showAlert, style: .success)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UIDemoList()
    }
}

struct ListRow: View {
    let name: String
    var note: String? = nil
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(name) {
                withAnimation(.spring()) {
                    action()
                }
            }
            if let note = note {
                Text(note)
                    .font(.system(size: 12, weight: .light, design: .rounded))
            }
        }
        .padding(.vertical, 6)
    }
}
