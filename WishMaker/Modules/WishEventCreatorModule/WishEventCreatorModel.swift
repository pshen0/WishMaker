//
//  WishEventCreatorModel.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import UIKit

enum WishEventCreatorModel {
    
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
    
    // MARK: - CheckDates
    enum CheckDates {
        struct Request { 
            let start: String
            let end: String
        }
    }
    
    // MARK: - CreateEvent
    enum CreateEvent {
        struct Request {
            let title: String
            let note: String?
            let startDate: Date
            let endDate: Date
        }
    }
    
    // MARK: - RouteBack
    enum RouteBack {
        struct Request { }
        struct Response { }
    }
}
