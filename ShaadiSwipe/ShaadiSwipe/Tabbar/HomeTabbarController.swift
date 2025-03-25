//
//  HomeTabbarController.swift
//  ShaadiSwipe
//
//  Created by Vamshi Reddy on 21/03/25.
//

import UIKit

final class HomeTabbarController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTabs()
        setupUItabBar()
    }
    
    private func setupUItabBar() {
        
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = .label
    }
    
    private func setupTabs() {
        
        let homeVC = createNavController(for: RejectedViewController(), title: "Rejected", image: UIImage(systemName: "xmark"))
        let searchVC = createNavController(for: AcceptedViewController(), title: "Accepted", image: UIImage(systemName: "checkmark"))
        let profileVC = createNavController(for: HomeViewController(), title: "Profile", image: UIImage(systemName: "person"))

        self.viewControllers = [homeVC, profileVC, searchVC]
        self.selectedIndex = 1
    }

    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage?) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        
        return navController
    }
}
