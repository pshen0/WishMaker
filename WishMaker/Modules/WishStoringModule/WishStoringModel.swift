//
//  WishStoringModel.swift
//  WishMaker
//
//  Created by Анна Сазонова on 19.02.2025.
//

import UIKit

enum WishStoringModel {
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
            let wishes: [WishEntity]
        }
        struct ViewModel { }
    }
    
    // MARK: - Add
    enum Add {
        struct Request {
            let text: String
        }
        struct Response {
            let wishes: [WishEntity]
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
            let wishes: [WishEntity]
        }
        struct ViewModel {
            let indexPath: IndexPath
        }
    }
    
    // MARK: - RouteBack
    enum RouteBack {
        struct Request { }
        struct Response { }
    }
    
}
