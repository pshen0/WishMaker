//
//  WishStoringBuilder.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import UIKit

enum WishStoringBuilder {
    static func build() -> WishStoringViewController {
        let presenter = WishStoringPresenter()
        let interactor = WishStoringInteractor(presenter: presenter)
        let view = WishStoringViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
