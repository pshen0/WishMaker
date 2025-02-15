//
//  WishCalendarPresenter.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import Foundation

protocol WishCalendarPresenterProtocol {
    
}

final class WishCalendarPresenter: WishCalendarPresenterProtocol {
    
    weak var view: WishCalendarViewProtocol?
    var interactor: WishCalendarInteractorProtocol?

}
