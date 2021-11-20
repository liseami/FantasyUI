//
//  ExampleApp.swift
//  Example
//
//  Created by Liseami on 2021/11/20.
//

import SwiftUI

@main
struct ExampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
