//
//  SceneDelegate.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = BookListViewController()
        window?.windowScene = windowScene
        window?.rootViewController = SelectAnimationNavigationViewController(rootViewController: mainViewController)
        window?.makeKeyAndVisible()
    }
}

