//
//  CoreDataStack.swift
//  WishMaker
//
//  Created by Анна Сазонова on 17.02.2025.
//

import CoreData

enum CoreDataConstants {
    static let containerName: String = "DataModels"
    static let loadError: String = "Ошибка загрузки"
    static let deleteError: String = "Ошибка удаления"
    static let saveError: String = "Ошибка сохранения"
    
    static let eventSortKey: String = "startDate"
    static let wishSortKey: String = "dateAdded"
}

final class CoreDataEventStack {
    
    static let shared = CoreDataEventStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataConstants.containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(CoreDataConstants.loadError)
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
            }
        }
    }
    
    func fetchEvents() -> [EventEntity] {
        let context = CoreDataEventStack.shared.context
        let fetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: CoreDataConstants.eventSortKey, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(CoreDataConstants.loadError)
            return []
        }
    }
    
    func deleteEvent(_ event: EventEntity) {
        let context = persistentContainer.viewContext
        context.delete(event)
        
        do {
            try context.save()
        } catch {
            print(CoreDataConstants.deleteError)
        }
    }
}


final class CoreDataWishStack {
    static let shared = CoreDataWishStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataConstants.containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(CoreDataConstants.loadError)
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(CoreDataConstants.saveError)
            }
        }
    }
    
    func fetchWishes() -> [WishEntity] {
        let fetchRequest: NSFetchRequest<WishEntity> = WishEntity.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: CoreDataConstants.wishSortKey, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(CoreDataConstants.loadError)
            return []
        }
    }
    
    func addWish(_ text: String) {
        let newWish = WishEntity(context: context)
        newWish.text = text
        newWish.dateAdded = Date()
        saveContext()
    }
    
    func deleteWish(_ wish: WishEntity) {
        context.delete(wish)
        saveContext()
    }
}
