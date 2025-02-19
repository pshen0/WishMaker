//
//  WishMakerBuilder.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 12.02.2025.
//

import UIKit

enum WishMakerBuilder {
    static func build() -> WishMakerViewController {
        let presenter = WishMakerPresenter()
        let interactor = WishMakerInteractor(presenter: presenter)
        let view = WishMakerViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
