//
//  Exercise-CoreDataHelpers.swift
//  WorkoutTracker
//
//  Created by Fahim Uddin on 5/8/26.
//

import CoreData
import Foundation

extension Exercise {
    var workoutName: String {
        get { name ?? "" }
        set { name = newValue }
    }
    
    var workoutContent: String {
        get { content ?? "" }
        set { content = newValue }
    }
    
    var workoutCreationDate: Date {
        creationDate ?? .now
    }
    
    var workoutModificationDate: Date {
        modifciationDate ?? .now
    }
    
    var exerciseTags: [Tag] {
        let result = tags?.allObjects as? [Tag] ?? []
        return result.sorted()
    }
    
    static var example: Exercise {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let exercise = Exercise(context: viewContext)
        exercise.name = "Example Exercise"
        exercise.content = "This is an example exercise"
        exercise.priority = 2
        exercise.creationDate = .now
        return exercise
    }
}

extension Exercise: Comparable {
    public static func <(lhs: Exercise, rhs: Exercise) -> Bool {
        let left = lhs.workoutName.localizedLowercase
        let right = rhs.workoutName.localizedLowercase
        
        if left == right {
            return lhs.workoutCreationDate < rhs.workoutCreationDate
        } else {
            return left < right
        }
    }
}
