//
//  WishCalendarModuleBuilder.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//


import UIKit

enum WishCalendarBuilder {
    static func build() -> WishCalendarViewController {
        let presenter = WishCalendarPresenter()
        let interactor = WishCalendarInteractor(presenter: presenter)
        let view = WishCalendarViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}

