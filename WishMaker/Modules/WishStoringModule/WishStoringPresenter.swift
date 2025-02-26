//
//  WishStoringPresenter.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import Foundation

// MARK: - PresentationLogic protocol
protocol WishStoringPresentationLogic {
    func setColors(_ response: WishStoringModel.Load.Response)
    func presentWishes(_ response: WishStoringModel.Fetch.Response)
    func presentWishAdded(_ response: WishStoringModel.Add.Response)
    func presentWishDeleted(_ response: WishStoringModel.Delete.Response)
    func routeBack(_ response: WishStoringModel.RouteBack.Response)
}

final class WishStoringPresenter: WishStoringPresentationLogic {
    
    // MARK: - Fields
    weak var view: WishStoringViewController?
    
    
    // MARK: - Funcs
    func setColors(_ response: WishStoringModel.Load.Response) {
        let viewModel = WishStoringModel.Load.ViewModel(
            mainColor: response.mainColor,
            additionalColor: response.additionalColor
        )
        view?.updateColors(viewModel)
    }
    
    func presentWishes(_ response: WishStoringModel.Fetch.Response) {
        view?.wishes = response.wishes
        view?.displayLoading(WishStoringModel.Fetch.ViewModel())
    }
    
    func presentWishAdded(_ response: WishStoringModel.Add.Response) {
        view?.wishes = response.wishes
        view?.displayAdding(WishStoringModel.Add.ViewModel())
    }
    
    func presentWishDeleted(_ response: WishStoringModel.Delete.Response) {
        view?.wishes.remove(at: response.indexPath.row)
        view?.displayDeleting(WishStoringModel.Delete.ViewModel(indexPath: response.indexPath))
    }
    
    func routeBack(_ response: WishStoringModel.RouteBack.Response) {
        view?.dismiss(animated: true, completion: nil)
    }
}
