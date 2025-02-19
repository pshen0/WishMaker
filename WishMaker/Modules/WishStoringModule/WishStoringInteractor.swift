//
//  WishStoringInteractor.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import Foundation

protocol WishStoringBusinessLogic {
    func loadWishes(_ request: WishStoringModel.Fetch.Request)
    func addWish(_ request: WishStoringModel.Add.Request)
    func deleteWish(_ request: WishStoringModel.Delete.Request)
}

final class WishStoringInteractor: WishStoringBusinessLogic {
    
    private let presenter: WishStoringPresentationLogic
    private let wishService = CoreDataWishStack.shared
    
    init(presenter: WishStoringPresentationLogic) {
        self.presenter = presenter
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
}
