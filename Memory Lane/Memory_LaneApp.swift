//
//  Memory_LaneApp.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import SwiftUI

@main
struct Memory_LaneApp: App {
//    let persistenceController = PersistenceController.shared
    
    
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 63/255, green: 95/255, blue: 58/255, alpha: 1)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
        
        //    var body: some Scene {
        //        WindowGroup {
        //            ContentView()
        //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        //        }
        //    }

}
