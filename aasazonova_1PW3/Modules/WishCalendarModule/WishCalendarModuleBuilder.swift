//
//  WishCalendarModuleBuilder.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation

final class WishCalendarModuleBuilder {
    static func build() -> WishCalendarViewController {
        let viewController = WishCalendarViewController()
        let presenter = WishCalendarPresenter()
        let interactor = WishCalendarInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        
        return viewController
    }
}
