//
//  CoreDataStack.swift
//  WishMaker
//
//  Created by Анна Сазонова on 17.02.2025.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EventModel") // Название .xcdatamodeld
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
                print("✅ Данные успешно сохранены!")
            } catch {
                let nserror = error as NSError
                print("❌ Ошибка сохранения контекста: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchEvents() -> [EventEntity] {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Ошибка загрузки событий: \(error)")
            return []
        }
    }
}
