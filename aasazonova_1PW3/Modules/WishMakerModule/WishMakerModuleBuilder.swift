//
//  WishMakerBuilder.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 12.02.2025.
//

import Foundation

final class WishMakerModuleBuilder {
    static func build() -> WishMakerViewController {
        let viewController = WishMakerViewController()
        let presenter = WishMakerPresenter()
        let interactor = WishMakerInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        
        return viewController
    }
}
