//
//  Presenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import Foundation

protocol ColorPresenterInput {
    func colorsDidUpdate(red: CGFloat, green: CGFloat, blue: CGFloat)
}

protocol ColorPresenter {
    func slidersValueDidChange(red: CGFloat, green: CGFloat, blue: CGFloat)
}

class ColorPresenterImplementation: ColorPresenter, ColorPresenterInput {
    
    weak var view: ColorView!
    var interactor: ColorInteractorInput!
    var router: ColorRouter!

    func slidersValueDidChange(red: CGFloat, green: CGFloat, blue: CGFloat) {
        interactor.updateColors(red: red, green: green, blue: blue)
    }

    func colorsDidUpdate(red: CGFloat, green: CGFloat, blue: CGFloat) {
        view.updateBackgroundColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue))
    }
}
