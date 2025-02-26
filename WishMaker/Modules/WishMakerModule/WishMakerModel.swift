//
//  WishMakerModel.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import UIKit

enum WishMakerModel {
    // MARK: - Load
    enum Load {
        struct Request { }
        struct Response {
            let mainColor: UIColor
            let additionalColor: UIColor
        }
    }
    
    // MARK: - ColorChange
    enum ColorChange {
        struct Request {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
        struct Response {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
        struct ViewModel {
            let mainColor: UIColor
            let additionalColor: UIColor
        }
    }
    
    // MARK: - RouteToWishStoring
    enum RouteToWishStoring {
        struct Request { }
        struct Response { }
    }
    
    // MARK: - RouteToWishCalendar
    enum RouteToWishCalendar {
        struct Request { }
        struct Response { }
    }
}
