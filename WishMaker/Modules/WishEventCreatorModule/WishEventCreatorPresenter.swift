//
//  WishEventCreatorPresenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation

// MARK: - PresentationLogic protocol
protocol WishEventCreatorPresentationLogic {
    func setColors(_ response: WishEventCreatorModel.Load.Response)
    func routeBack(_ response: WishEventCreatorModel.RouteBack.Response)
}

final class WishEventCreatorPresenter: WishEventCreatorPresentationLogic {
    
    // MARK: - Fields
    weak var view: WishEventCreatorViewController?
    
    
    // MARK: - Funcs
    func setColors(_ response: WishEventCreatorModel.Load.Response) {
        let viewModel = WishEventCreatorModel.Load.ViewModel(
            mainColor: response.mainColor,
            additionalColor: response.additionalColor
        )
        view?.updateColors(viewModel)
    }
    
    func routeBack(_ response: WishEventCreatorModel.RouteBack.Response) {
        view?.dismiss(animated: true, completion: nil)
    }
}
