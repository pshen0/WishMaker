//
//  WishMakerModel.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import UIKit

enum WishMakerModel {
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
            let backgroundColor: UIColor
            let textColor: UIColor
        }
    }
    
    enum RouteToWishStoring {
        struct Request { }
        struct Response { }
    }
    
    enum RouteToWishCalendar {
        struct Request { }
        struct Response { }
    }
}
