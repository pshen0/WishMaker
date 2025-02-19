//
//  Presenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

protocol WishMakerPresentationLogic {
    func presentBackgroundColor(_ response: WishMakerModel.ColorChange.Response, textColor: UIColor)
    func routeToWishStoring(_ response: WishMakerModel.RouteToWishStoring.Response)
    func routeToWishCalendar(_ response: WishMakerModel.RouteToWishCalendar.Response)
}

final class WishMakerPresenter: WishMakerPresentationLogic {
    
    weak var view: WishMakerViewController?
    
    func presentBackgroundColor(_ response: WishMakerModel.ColorChange.Response, textColor: UIColor) {
        let viewModel = WishMakerModel.ColorChange.ViewModel(
            backgroundColor: UIColor(red: response.red, green: response.green, blue: response.blue, alpha:  WishMakerViewController.Constants.colorSaturation),
            textColor: textColor
        )
        view?.updateBackground(viewModel)
    }
    
    func routeToWishStoring(_ response: WishMakerModel.RouteToWishStoring.Response) {
        view?.present(WishStoringBuilder.build(), animated: true)
    }
    
    func routeToWishCalendar(_ response: WishMakerModel.RouteToWishCalendar.Response) {
        view?.navigationController?.pushViewController(WishCalendarBuilder.build(), animated: true)
    }
}
