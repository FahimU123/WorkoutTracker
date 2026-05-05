//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Fahim Uddin on 5/5/26.
//

import SwiftUI

@main
struct WorkoutTrackerApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
