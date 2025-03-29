//
//  VitAlApp.swift
//  VitAl
//
//  Created by Nate Felix on 3/28/25.
//

import SwiftUI

@main
struct VitAlApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
