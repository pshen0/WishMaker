//
//  WishEventCreatorModel.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import UIKit

enum WishEventCreatorModel {
    enum CheckDates {
        struct Request { 
            let start: String
            let end: String
        }
    }
    
    enum CreateEvent {
        struct Request {
            let title: String
            let note: String?
            let startDate: Date
            let endDate: Date
        }
    }
    
    enum RouteBack {
        struct Request { }
        struct Response { }
    }

}
