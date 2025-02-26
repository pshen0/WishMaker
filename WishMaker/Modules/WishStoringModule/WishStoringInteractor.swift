//
//  WishStoringInteractor.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import Foundation

// MARK: - BusinessLogic protocol
protocol WishStoringBusinessLogic {
    func loadController(_ request: WishStoringModel.Load.Request)
    func loadWishes(_ request: WishStoringModel.Fetch.Request)
    func addWish(_ request: WishStoringModel.Add.Request)
    func deleteWish(_ request: WishStoringModel.Delete.Request)
    func backButtonTapped(_ request: WishStoringModel.RouteBack.Request)
}

final class WishStoringInteractor: WishStoringBusinessLogic {
    
    // MARK: - Fields
    private let presenter: WishStoringPresentationLogic
    private let wishService = CoreDataWishStack.shared
    
    // MARK: - Lifecycle
    init(presenter: WishStoringPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Funcs
    func loadController(_ request: WishStoringModel.Load.Request) {
        let savedMainColor = UserDefaults.standard.color(forKey: WishStoringViewController.Constants.mainColorID) ??
        WishStoringViewController.Constants.black
        let savedAdditionalColor = UserDefaults.standard.color(forKey: WishStoringViewController.Constants.additionalColorID) ??
        WishStoringViewController.Constants.white
        presenter.setColors(WishStoringModel.Load.Response(mainColor: savedMainColor, additionalColor: savedAdditionalColor))
    }
    
    func loadWishes(_ request: WishStoringModel.Fetch.Request) {
        let wishes = wishService.fetchWishes()
        presenter.presentWishes(WishStoringModel.Fetch.Response(wishes: wishes))
    }
    
    func addWish(_ request: WishStoringModel.Add.Request) {
        wishService.addWish(request.text)
        let wishes = wishService.fetchWishes()
        presenter.presentWishAdded(WishStoringModel.Add.Response(wishes: wishes))
    }
    
    func deleteWish(_ request: WishStoringModel.Delete.Request) {
        let wishToDelete = wishService.fetchWishes()[request.indexPath.row]
        CoreDataWishStack.shared.deleteWish(wishToDelete)
        let wishes = wishService.fetchWishes()
        presenter.presentWishDeleted(WishStoringModel.Delete.Response(indexPath: request.indexPath, wishes: wishes))
    }
    
    func backButtonTapped(_ request: WishStoringModel.RouteBack.Request) {
        presenter.routeBack(WishStoringModel.RouteBack.Response())
    }
}
