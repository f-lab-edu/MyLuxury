//
//  HomeCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

public protocol HomeCoordinator: Coordinator {
 
    var navigationController: UINavigationController { get set }
}

public class HomeCoordinatorImpl: HomeCoordinator {

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    
    public init(navigationController: UINavigationController) {
        
        print("HomeCoordinatorImpl init")
        
        self.navigationController = navigationController
    }
    
    deinit {
        print("HomeCoordinatorImpl deinit")
    }
    
    public func start() {
        
        let homeVM = HomeViewModel()
        let homeVC = HomeViewController(homeVM: homeVM)
        
        self.navigationController = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: TabBarItem.home.title, image: UIImage(systemName: TabBarItem.home.image), tag: 0)
    }
}
