//
//  WishEventCreationPresenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation

protocol WishEventCreationPresenterProtocol {
    func createEvent(title: String, note: String?, startDate: Date, endDate: Date) -> Bool
}

final class WishEventCreationPresenter: WishEventCreationPresenterProtocol {
    
    weak var view: WishEventCreationViewProtocol?
    var interactor: WishEventCreationInteractorProtocol?
    
    private let eventManager: CalendarEventManagerProtocol
    
    init(eventManager: CalendarEventManagerProtocol) {
        self.eventManager = eventManager
    }
    
    func createEvent(title: String, note: String?, startDate: Date, endDate: Date) -> Bool {
        let eventModel = CalendarEventModel(title: title, startDate: startDate, endDate: endDate, note: note)
            
            let isCreated = eventManager.create(eventModel: eventModel)
            if isCreated {
                saveEventToCoreData(eventModel: eventModel)
            }
            return isCreated
    }
    
    func saveEventToCoreData(eventModel: CalendarEventModel) {
        let context = CoreDataStack.shared.context
        context.performAndWait {
            let eventEntity = EventEntity(context: context)
            
            eventEntity.title = eventModel.title
            eventEntity.startDate = eventModel.startDate
            eventEntity.endDate = eventModel.endDate
            eventEntity.note = eventModel.note
            
            do {
                try context.save()
            } catch {
                print("Ошибка сохранения события: \(error.localizedDescription)")
            }
        }
    }
}

