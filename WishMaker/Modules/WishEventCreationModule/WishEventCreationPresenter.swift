//
//  WishEventCreationPresenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation

protocol WishEventCreationPresenterProtocol {
    
}

final class WishEventCreationPresenter: WishEventCreationPresenterProtocol {
    
    weak var view: WishEventCreationViewProtocol?
    var interactor: WishEventCreationInteractorProtocol?

}

