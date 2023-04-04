//
//  Memory_LaneApp.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import SwiftUI

@main
struct Memory_LaneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
