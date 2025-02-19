//
//  WishCalendarInteractor.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation

protocol WishCalendarBusinessLogic {
    func loadEvents(_ request: WishCalendarModel.Fetch.Request)
    func deleteEvent(_ request: WishCalendarModel.Delete.Request)
    func addEventButtonTapped(_ request: WishCalendarModel.RouteToWishEventCreator.Request)
    func backButtonTapped(_ request: WishCalendarModel.RouteBack.Request)
}

final class WishCalendarInteractor: WishCalendarBusinessLogic {
    
    private let presenter: WishCalendarPresentationLogic
    private let eventsService = CoreDataEventStack.shared
    
    init(presenter: WishCalendarPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadEvents(_ request: WishCalendarModel.Fetch.Request) {
        let events = eventsService.fetchEvents()
        presenter.presentEvents(WishCalendarModel.Fetch.Response(events: events))
    }
    
    func deleteEvent(_ request: WishCalendarModel.Delete.Request) {
        let eventToDelete = eventsService.fetchEvents()[request.indexPath.item]
        CoreDataEventStack.shared.deleteEvent(eventToDelete)
        presenter.presentEventDeleted(WishCalendarModel.Delete.Response(indexPath: request.indexPath))
    }
    
    func addEventButtonTapped(_ request: WishCalendarModel.RouteToWishEventCreator.Request) {
        let wishEventCreationVC = WishEventCreatorBuilder.build()
        
        wishEventCreationVC.onEventAdded = { [weak self] in
            let events = self?.eventsService.fetchEvents()
            self?.presenter.presentEvents(WishCalendarModel.Fetch.Response(events: events ?? []))
        }
        
        presenter.routeToWishEventCreator(WishCalendarModel.RouteToWishEventCreator.Response(viewController: wishEventCreationVC))
    }
    
    func backButtonTapped(_ request: WishCalendarModel.RouteBack.Request) {
        presenter.routeBack(WishCalendarModel.RouteBack.Response())
    }
}
