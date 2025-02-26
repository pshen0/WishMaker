//
//  WishCalendarModel.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import UIKit

enum WishCalendarModel {
    
    // MARK: - Load
    enum Load {
        struct Request { }
        struct Response {
            let mainColor: UIColor
            let additionalColor: UIColor
        }
        struct ViewModel {
            let mainColor: UIColor
            let additionalColor: UIColor
        }
    }
    
    // MARK: - Fetch
    enum Fetch {
        struct Request { }
        struct Response {
            let events: [EventEntity]
        }
        struct ViewModel { }
    }
    
    // MARK: - Delete
    enum Delete {
        struct Request {
            let indexPath: IndexPath
        }
        struct Response {
            let indexPath: IndexPath
        }
        struct ViewModel {
            let indexPath: IndexPath
        }
    }
    
    // MARK: - RouteToWishEventCreator
    enum RouteToWishEventCreator {
        struct Request { }
        struct Response {
            let viewController: WishEventCreatorViewController
        }
    }
    
    // MARK: - RouteBack
    enum RouteBack {
        struct Request { }
        struct Response { }
    }
}
