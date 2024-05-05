//
//  TabBarController.swift
//  AppStore
//
//  Created by Ualikhan Sabden on 02.12.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createController(viewController: MainViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Weather", imageName: "today_icon"),
            createController(viewController: MusicViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Music", imageName: "apps"),
            createController(viewController: SearchController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Search", imageName: "search")
        ]
    }
    
    func createController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }

}

