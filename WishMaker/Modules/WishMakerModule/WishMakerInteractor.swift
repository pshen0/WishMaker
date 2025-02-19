//
//  Interactor.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

protocol WishMakerBusinessLogic {
    func changedSliderPosition(_ request: WishMakerModel.ColorChange.Request)
    func addWishButtonPressed()
    func scheduleWishButtonPressed()
}

final class WishMakerInteractor: WishMakerBusinessLogic {
    
    private let presenter: WishMakerPresentationLogic
    
    init(presenter: WishMakerPresentationLogic) {
        self.presenter = presenter
    }
    
    func changedSliderPosition(_ request: WishMakerModel.ColorChange.Request) {
        let brightness = Double(request.red + request.green + request.blue)
        let textColor: UIColor = brightness > WishMakerViewController.Constants.brightnessLevel ? .black : .white
        let response = WishMakerModel.ColorChange.Response(
            red: request.red,
            green: request.green,
            blue: request.blue
        )
        presenter.presentBackgroundColor(response, textColor: textColor)
    }
    
    func addWishButtonPressed() {
        presenter.routeToWishStoring()
    }
    
    func scheduleWishButtonPressed() {
        presenter.routeToWishCalendar()
    }
}
