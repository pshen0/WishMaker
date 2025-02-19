//
//  WishCalendarModel.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import UIKit

enum WishCalendarModel {
    enum Fetch {
        struct Request { }
        struct Response {
            let events: [EventEntity]
        }
        struct ViewModel { }
    }
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
    
    enum RouteToWishEventCreator {
        struct Request { }
        struct Response {
            let viewController: WishEventCreatorViewController
        }
    }
    
    enum RouteBack {
        struct Request { }
        struct Response { }
    }
}
