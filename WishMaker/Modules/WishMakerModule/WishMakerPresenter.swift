//
//  Presenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

// MARK: - PresentationLogic protocol
protocol WishMakerPresentationLogic {
    func setColors(_ response: WishMakerModel.Load.Response)
    func changeColors(_ response: WishMakerModel.ColorChange.Response)
    func routeToWishStoring(_ response: WishMakerModel.RouteToWishStoring.Response)
    func routeToWishCalendar(_ response: WishMakerModel.RouteToWishCalendar.Response)
}

final class WishMakerPresenter: WishMakerPresentationLogic {
    
    // MARK: - Fields
    weak var view: WishMakerViewController?
    
    // MARK: - Private funcs
    private func getAdditionalColor(_ color: UIColor) -> UIColor {
        var redLevel: CGFloat = 0
        var greenLevel: CGFloat = 0
        var blueLevel: CGFloat = 0
        var alphaLevel: CGFloat = 0
        color.getRed(&redLevel, green: &greenLevel, blue: &blueLevel, alpha: &alphaLevel)
        
        let additionalColor = redLevel + greenLevel + blueLevel > WishMakerViewController.Constants.brightnessLevel ? UIColor.black : UIColor.white
        return additionalColor
    }
    // MARK: - Funcs
    func setColors(_ response: WishMakerModel.Load.Response) {
        let viewModel = WishMakerModel.ColorChange.ViewModel(
            mainColor: response.mainColor,
            additionalColor: response.additionalColor
        )
        view?.updateColors(viewModel)
    }
    
    func changeColors(_ response: WishMakerModel.ColorChange.Response) {
        let color = UIColor(red: response.red, green: response.green, blue: response.blue, alpha:  WishMakerViewController.Constants.colorSaturation)
        let additionalColor = getAdditionalColor(color)
        let viewModel = WishMakerModel.ColorChange.ViewModel(
            mainColor: color,
            additionalColor: additionalColor
        )
        UserDefaults.standard.setColor(color, forKey: "mainColor")
        UserDefaults.standard.setColor(additionalColor, forKey: "additionalColor")
        view?.updateColors(viewModel)
    }
    
    func routeToWishStoring(_ response: WishMakerModel.RouteToWishStoring.Response) {
        view?.present(WishStoringBuilder.build(), animated: true)
    }
    
    func routeToWishCalendar(_ response: WishMakerModel.RouteToWishCalendar.Response) {
        view?.navigationController?.pushViewController(WishCalendarBuilder.build(), animated: true)
    }
}
