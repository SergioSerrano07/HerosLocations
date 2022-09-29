//
//  SceneDelegate.swift
//  AppleMaps
//
//  Created by sergio serrano on 13/9/22.
//

import UIKit
import KeychainSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        
        let keyChain = KeychainSwift()
        
        let firstVC: UIViewController
        if keyChain.get("KCToken") != nil {
            firstVC = TableViewController()
        } else {
            firstVC = LoginViewController()
        }
        
        navigationController.setViewControllers([firstVC], animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
    }
}

