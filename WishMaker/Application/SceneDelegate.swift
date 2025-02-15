//
//  SceneDelegate.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navC = UINavigationController(rootViewController: WishMakerModuleBuilder.build())
        window.rootViewController = navC
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        //UserDefaults.standard.removeObject(forKey: "wishesKey")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        //UserDefaults.standard.removeObject(forKey: "wishesKey")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        //UserDefaults.standard.removeObject(forKey: "wishesKey")
        }

    func sceneWillEnterForeground(_ scene: UIScene) {
        //UserDefaults.standard.removeObject(forKey: "wishesKey")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        //UserDefaults.standard.removeObject(forKey: "wishesKey")
    }


}

