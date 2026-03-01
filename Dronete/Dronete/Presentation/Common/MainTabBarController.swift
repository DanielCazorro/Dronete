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
        let news = makeNewsNav()
        let drones = makePlaceholderNav(title: "Modelos", symbol: "airplane")
        let regulations = makePlaceholderNav(title: "Regulación", symbol: "globe")
        let profile = makePlaceholderNav(title: "Perfil", symbol: "person.crop.circle")

        viewControllers = [news, drones, regulations, profile]
    }

    private func makeNewsNav() -> UINavigationController {
        let service = MockNewsAPIService()
        let repository = NewsRepositoryImpl(service: service)
        let useCase = GetNewsUseCase(repository: repository)
        let viewModel = NewsListViewModel(getNewsUseCase: useCase)
        let vc = NewsListViewController(viewModel: viewModel)
        vc.title = "Noticias"

        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(
            title: "Noticias",
            image: UIImage(systemName: "newspaper"),
            tag: 0
        )
        return nav
    }

    private func makePlaceholderNav(title: String, symbol: String) -> UINavigationController {
        let vc = PlaceholderViewController(screenTitle: title)
        vc.title = title

        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: symbol), tag: 0)
        return nav
    }
}
