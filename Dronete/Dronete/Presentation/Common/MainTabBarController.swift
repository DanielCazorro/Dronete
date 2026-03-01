//
//  MainTabBarController.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let news = makeNav(title: "Noticias", symbol: "newspaper")
        let drones = makeNav(title: "Modelos", symbol: "airplane")
        let regulations = makeNav(title: "Regulación", symbol: "globe")
        let profile = makeNav(title: "Perfil", symbol: "person.crop.circle")

        viewControllers = [news, drones, regulations, profile]
    }

    private func makeNav(title: String, symbol: String) -> UINavigationController {
        let vc = PlaceholderViewController(screenTitle: title)
        vc.title = title

        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: symbol), tag: 0)
        return nav
    }
}
