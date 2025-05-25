//
//  SceneDelegate.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 30/1/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
            _ scene: UIScene,
            willConnectTo session: UISceneSession,
            options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        // ✅ Estilo visual del tab bar antes de crear las vistas
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = .white // Activo
        tabBarAppearance.unselectedItemTintColor = UIColor.lightGray // Inactivo

        let window = UIWindow(windowScene: scene)

        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        mainVC.tabBarItem = UITabBarItem(title: "Inicio", image: UIImage(systemName: "house"), tag: 0)

        let settingsVC = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        settingsVC.tabBarItem = UITabBarItem(title: "Ajustes", image: UIImage(systemName: "gearshape"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: mainVC),
            UINavigationController(rootViewController: settingsVC)
        ]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
