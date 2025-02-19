//
//  WishEventCreatorModuleBuilder.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation

import UIKit

enum WishEventCreatorBuilder {
    static func build() -> WishEventCreatorViewController {
        let presenter = WishEventCreatorPresenter()
        let interactor = WishEventCreatorInteractor(presenter: presenter)
        let view = WishEventCreatorViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
