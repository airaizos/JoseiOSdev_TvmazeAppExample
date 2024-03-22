//
//  CoreDataController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 21/03/24.
//

import Foundation
import CoreData

class CoreDataController {
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: Constants.DATA_BASE)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        context.perform {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let persistenContainer = persistentContainer.viewContext
        persistenContainer.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return persistenContainer
    }
    
    func getBackgroundContext() -> NSManagedObjectContext {//no ha sido probado y al parecer con solo activar en el proyecto el backgroundmode fetch con eso funciona el segundo plano
        return persistentContainer.newBackgroundContext()
    }
    
    func cleanEntity(entity : String, predicate : String?) { // predicate in format "property == 1"
        
        let managedContext = self.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        if (predicate != nil) {
            fetch.predicate = NSPredicate(format: predicate!)
        }
        
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch let error {
            debugPrint(error.localizedDescription)
        }
        saveContext()
    }
    
    func deleteItem(object : NSManagedObject) -> Bool {
        
        let managedContext = self.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(objectIDs: [object.objectID])
        var response = false
        do {
            try managedContext.execute(DelAllReqVar)
            response = true
        }
        catch {
            debugPrint("<<<<<< coreData DEleteerror: \(error)")
        }
        saveContext()
        return response
    }
    
    func deleteItem(objectID : NSManagedObjectID?) -> Bool {
        guard let objectID = objectID else {return false}
        let managedContext = self.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(objectIDs: [objectID])
        var response = false
        do {
            try managedContext.execute(DelAllReqVar)
            response = true
        }
        catch {
            debugPrint("<<<<<< coreData DEleteerror: \(error)")
        }
        saveContext()
        return response
    }
    
}

