//
//  SceneDelegate.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        let assemblyBuilder = ModuleBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

