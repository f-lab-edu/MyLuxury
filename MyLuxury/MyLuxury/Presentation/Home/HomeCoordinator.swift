//
//  HomeCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var appComponent: AppComponent
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(appComponent: AppComponent, navigationController: UINavigationController) {
        self.appComponent = appComponent
        self.navigationController = navigationController
    }
    
    func start() {
        
        let homeVM = HomeViewModel()
        let homeVC = HomeViewController(homeVM: homeVM)
        
        self.navigationController = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: TabBarItem.home.title, image: UIImage(systemName: TabBarItem.home.image), tag: 0)
    }
}
