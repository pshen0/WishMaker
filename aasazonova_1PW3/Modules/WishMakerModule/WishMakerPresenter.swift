//
//  Presenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import Foundation

protocol WishMakerPresenterProtocol {
    func slidersValueDidChange(red: CGFloat, green: CGFloat, blue: CGFloat)
}

final class WishMakerPresenter: WishMakerPresenterProtocol {
    
    weak var view: WishMakerViewProtocol?
    var interactor: WishMakerInteractorProtocol?

    func slidersValueDidChange(red: CGFloat, green: CGFloat, blue: CGFloat) {
        view?.updateBackgroundColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue))
    }
}
