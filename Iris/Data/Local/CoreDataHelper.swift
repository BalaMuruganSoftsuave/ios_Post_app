//
//  CoreDataHelper.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//

import CoreData
class CoreDataHelper {
    private var viewContext: NSManagedObjectContext
    
    static let shared = CoreDataHelper()
    var context: NSManagedObjectContext {
        return viewContext
    }
    
    //Context Initialization
    private init() {
        let container = NSPersistentContainer(name: "LocalData")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        viewContext = container.viewContext
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    //Saving the data to CoreData
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Core Data save error: \(error.localizedDescription)")
        }
    }
    
    //Fetch data from CoreData
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print("Core Data fetch error: \(error.localizedDescription)")
            return []
        }
    }
    

}
