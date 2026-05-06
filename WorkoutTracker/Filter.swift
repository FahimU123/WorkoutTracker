//
//  Filter.swift
//  WorkoutTracker
//
//  Created by Fahim Uddin on 5/6/26.
//

import Foundation

struct Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    var icon: String
    var minModificationDate = Date.distantPast
    var tag: Tag?
    
    static let all = Filter(id: UUID(), name: "All Exercises", icon: "tray")
    static let recent = Filter(id: UUID(), name: "Recent Exercises", icon: "clock", minModificationDate: .now.addingTimeInterval(86400 * -7))
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
