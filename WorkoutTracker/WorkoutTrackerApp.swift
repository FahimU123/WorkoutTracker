//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Fahim Uddin on 5/5/26.
//

import SwiftUI
import CoreData

@main
struct WorkoutTrackerApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            NavigationSplitView  {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
