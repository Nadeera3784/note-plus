//
//  note_plusApp.swift
//  note-plus
//
//  Created by Nadeera Sampath on 2023-07-09.
//

import SwiftUI

@main
struct note_plusApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
