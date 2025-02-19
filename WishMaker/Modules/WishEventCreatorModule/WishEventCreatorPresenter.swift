//
//  WishEventCreatorPresenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation



protocol WishEventCreatorPresentationLogic {
    func routeBack(_ response: WishEventCreatorModel.RouteBack.Response)
}

final class WishEventCreatorPresenter: WishEventCreatorPresentationLogic {
    
    weak var view: WishEventCreatorViewController?
    
    func routeBack(_ response: WishEventCreatorModel.RouteBack.Response) {
        view?.dismiss(animated: true, completion: nil)
    }
}
