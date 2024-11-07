//
//  Interactor.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import Foundation

protocol ColorInteractorInput {
    func updateColors(red: CGFloat, green: CGFloat, blue: CGFloat)
}

class ColorInteractor: ColorInteractorInput {
    var presenter: ColorPresenterInput!

    func updateColors(red: CGFloat, green: CGFloat, blue: CGFloat) {
        presenter.colorsDidUpdate(red: red, green: green, blue: blue)
    }
}
