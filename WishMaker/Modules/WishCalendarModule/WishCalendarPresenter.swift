//
//  WishCalendarPresenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

protocol WishCalendarPresentationLogic {
    func presentEvents(_ respone: WishCalendarModel.Fetch.Response)
    func presentEventDeleted(_ response: WishCalendarModel.Delete.Response)
    func routeToWishEventCreator(_ response: WishCalendarModel.RouteToWishEventCreator.Response)
    func routeBack(_ response: WishCalendarModel.RouteBack.Response)
}

final class WishCalendarPresenter: WishCalendarPresentationLogic {
    
    weak var view: WishCalendarViewController?
    
    func presentEvents(_ respone: WishCalendarModel.Fetch.Response) {
        view?.events = respone.events
        view?.displayEvents(WishCalendarModel.Fetch.ViewModel())
    }
    
    func presentEventDeleted(_ response: WishCalendarModel.Delete.Response) {
        view?.events.remove(at: response.indexPath.item)
        view?.displayDeleting(WishCalendarModel.Delete.ViewModel(indexPath: response.indexPath))
    }

    
    func routeToWishEventCreator(_ response: WishCalendarModel.RouteToWishEventCreator.Response) {
        view?.present(response.viewController, animated: true)
    }
    
    func routeBack(_ response: WishCalendarModel.RouteBack.Response) {
        view?.navigationController?.popViewController(animated: true)
    }
}

