//
//  Router.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 06.11.2024.
//
import UIKit

protocol ColorRouterProtocol: AnyObject {
    func createModule() -> WishMakerViewController
}

class ColorRouter: ColorRouterProtocol {
    func createModule() -> WishMakerViewController {
        let view = WishMakerViewController()
        let presenter = ColorPresenterImplementation()
        let interactor = ColorInteractor()
        let router = ColorRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
