//
//  CoreDataStack.swift
//  WishMaker
//
//  Created by Анна Сазонова on 17.02.2025.
//

import CoreData

final class CoreDataEventStack {
    static let shared = CoreDataEventStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModels")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка загрузки хранилища: \(error)")
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
        
        let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteEvent(_ event: EventEntity) {
        let context = persistentContainer.viewContext
        context.delete(event)
        
        do {
            try context.save()
        } catch {
            print("Ошибка удаления: \(error.localizedDescription)")
        }
    }
}


final class CoreDataWishStack {
    static let shared = CoreDataWishStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModels")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка загрузки хранилища: \(error)")
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
                print("Ошибка сохранения: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchWishes() -> [WishEntity] {
        let fetchRequest: NSFetchRequest<WishEntity> = WishEntity.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Ошибка загрузки желаний: \(error.localizedDescription)")
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
