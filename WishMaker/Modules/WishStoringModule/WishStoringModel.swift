//
//  WishStoringModel.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import Foundation

enum WishStoringModel {
    
    enum Fetch {
        struct Request { }
        struct Response {
            let wishes: [WishEntity]
        }
        struct ViewModel { }
    }
    
    enum Add {
        struct Request {
            let text: String
        }
        struct Response {
            let wishes: [WishEntity]
        }
        struct ViewModel { }
    }
    
    enum Delete {
        struct Request {
            let indexPath: IndexPath
        }
        struct Response {
            let indexPath: IndexPath
            let wishes: [WishEntity]
        }
        struct ViewModel {
            let indexPath: IndexPath
        }
    }
    
    enum RouteBack {
        struct Request { }
        struct Response { }
    }
    
}
