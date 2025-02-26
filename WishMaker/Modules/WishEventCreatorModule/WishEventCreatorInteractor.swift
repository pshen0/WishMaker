//
//  WishEventCreatorInteractor.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import UIKit

// MARK: - BusinessLogic protocol
protocol WishEventCreatorBusinessLogic {
    func loadController(_ request: WishEventCreatorModel.Load.Request)
    func checkDates(_ request: WishEventCreatorModel.CheckDates.Request) -> Bool
    func eventIsCreated(_ request: WishEventCreatorModel.CreateEvent.Request) -> Bool
    func backButtonTapped(_ request: WishEventCreatorModel.RouteBack.Request)
}

final class WishEventCreatorInteractor: WishEventCreatorBusinessLogic {
    
    // MARK: - Fields
    private let presenter: WishEventCreatorPresentationLogic
    private let eventManager: CalendarEventManagerProtocol = CalendarEventManager()
    
    init(presenter: WishEventCreatorPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Private funcs
    private func saveEventToCoreData(eventModel: CalendarEventModel) {
        let context = CoreDataEventStack.shared.context
        context.performAndWait {
            let eventEntity = EventEntity(context: context)
            
            eventEntity.title = eventModel.title
            eventEntity.startDate = eventModel.startDate
            eventEntity.endDate = eventModel.endDate
            eventEntity.note = eventModel.note ?? WishEventCreatorViewController.Constants.emptyString
            
            do {
                try context.save()
            } catch {
                print(WishEventCreatorViewController.Constants.saveError)
            }
        }
    }
    
    // MARK: - Funcs
    func loadController(_ request: WishEventCreatorModel.Load.Request) {
        let savedMainColor = UserDefaults.standard.color(forKey: WishEventCreatorViewController.Constants.mainColorID) ??
        WishEventCreatorViewController.Constants.black
        let savedAdditionalColor = UserDefaults.standard.color(forKey: WishEventCreatorViewController.Constants.additionalColorID) ??
        WishEventCreatorViewController.Constants.white
        presenter.setColors(WishEventCreatorModel.Load.Response(mainColor: savedMainColor, additionalColor: savedAdditionalColor))
    }
    
    func checkDates(_ request: WishEventCreatorModel.CheckDates.Request) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = WishEventCreatorViewController.Constants.formatterString
        if let firstDate = dateFormatter.date(from: request.start), let secondDate = dateFormatter.date(from: request.end) {
            return firstDate <= secondDate
        } else {
            return false
        }
    }
    
    func eventIsCreated(_ request: WishEventCreatorModel.CreateEvent.Request) -> Bool {
        let eventModel = CalendarEventModel(title: request.title, startDate: request.startDate, endDate: request.endDate, note: request.note)
            
            let isCreated = eventManager.create(eventModel: eventModel)
            if isCreated {
                saveEventToCoreData(eventModel: eventModel)
            }
            return isCreated
    }
    
    func backButtonTapped(_ request: WishEventCreatorModel.RouteBack.Request) {
        presenter.routeBack(WishEventCreatorModel.RouteBack.Response())
    }
}

