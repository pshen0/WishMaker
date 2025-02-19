//
//  Presenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

protocol WishMakerPresentationLogic {
    func presentBackgroundColor(_ response: WishMakerModel.ColorChange.Response, textColor: UIColor)
    func routeToWishStoring()
    func routeToWishCalendar()
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
    
    func routeToWishStoring() {
        view?.present(WishStoringBuilder.build(), animated: true)
    }
    
    func routeToWishCalendar() {
        view?.navigationController?.pushViewController(WishCalendarViewController(), animated: true)
    }
}
