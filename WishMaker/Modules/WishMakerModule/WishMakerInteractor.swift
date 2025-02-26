//
//  Interactor.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

// MARK: - BusinessLogic protocol
protocol WishMakerBusinessLogic {
    func loadController(_ request: WishMakerModel.Load.Request)
    func changedSliderPosition(_ request: WishMakerModel.ColorChange.Request)
    func addWishButtonPressed(_ request: WishMakerModel.RouteToWishStoring.Request)
    func scheduleWishButtonPressed(_ request: WishMakerModel.RouteToWishCalendar.Request)
}

final class WishMakerInteractor: WishMakerBusinessLogic {
    
    // MARK: - Fields
    private let presenter: WishMakerPresentationLogic
    
    
    // MARK: - Lifecycle
    init(presenter: WishMakerPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Funcs
    func loadController(_ request: WishMakerModel.Load.Request) {
        let savedMainColor = UserDefaults.standard.color(forKey: WishMakerViewController.Constants.mainColorID) ??
        WishMakerViewController.Constants.black
        let savedAdditionalColor = UserDefaults.standard.color(forKey: WishMakerViewController.Constants.additionalColorID) ??
        WishMakerViewController.Constants.white
        presenter.setColors(WishMakerModel.Load.Response(mainColor: savedMainColor, additionalColor: savedAdditionalColor))
    }
    
    func changedSliderPosition(_ request: WishMakerModel.ColorChange.Request) {
        let response = WishMakerModel.ColorChange.Response(
            red: request.red,
            green: request.green,
            blue: request.blue
        )
        presenter.changeColors(response)
    }
    
    func addWishButtonPressed(_ request: WishMakerModel.RouteToWishStoring.Request) {
        presenter.routeToWishStoring(WishMakerModel.RouteToWishStoring.Response())
    }
    
    func scheduleWishButtonPressed(_ request: WishMakerModel.RouteToWishCalendar.Request) {
        presenter.routeToWishCalendar(WishMakerModel.RouteToWishCalendar.Response())
    }
}
