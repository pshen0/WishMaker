//
//  WishEventCreationModuleBuilder.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation

final class WishEventCreationModuleBuilder {
    static func build() -> WishEventCreationViewController {
        let viewController = WishEventCreationViewController()
        let eventManager = CalendarEventManager()
        let presenter = WishEventCreationPresenter(eventManager: eventManager)
        let interactor = WishEventCreationInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        
        return viewController
    }
}
