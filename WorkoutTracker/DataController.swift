//
//  DataController.swift
//  WorkoutTracker 
//
//  Created by Fahim Uddin on 5/5/26.
//

import SwiftUI
import CoreData
import Combine

class DataController: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var selectedFilter: Filter? = Filter.all
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        dataController.createSampleData()
        return dataController
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    func createSampleData() {
        let viewContext = container.viewContext
        
        for i in 1...5 {
            let tag = Tag(context: viewContext)
            tag.id = UUID()
            tag.name = "Tag \(i)"
            
            for j in 1...10 {
                let exercise = Exercise(context: viewContext)
                exercise.name = "Exercise \(i)-\(j)"
                exercise.content = "Description goes here"
                exercise.completed = Bool.random()
                exercise.priority = Int16.random(in: 0...2)
                tag.addToExercises(exercise)
            }
        }
        
        try? viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        objectWillChange.send()
        container.viewContext.delete(object)
        save()
    }
    
    private func delete(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        if let delete = try? container.viewContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
            let changes = [NSDeletedObjectsKey: delete.result as? [NSManagedObjectID] ?? []]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [container.viewContext])
        }
    }
    
    func deleteAll() {
        let requestOne: NSFetchRequest<NSFetchRequestResult> = Tag.fetchRequest()
        delete(requestOne)
        
        let requestTwo: NSFetchRequest<NSFetchRequestResult> = Exercise.fetchRequest()
        delete(requestTwo)
        
        save()
    }
}
