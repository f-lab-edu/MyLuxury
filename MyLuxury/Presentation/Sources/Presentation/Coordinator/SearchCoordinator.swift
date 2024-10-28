//
//  SearchCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

public protocol SearchCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}

public class SearchCoordinatorImpl: SearchCoordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    
    public init(navigationController: UINavigationController) {
        print("SearchCoordinatorImpl init")
        self.navigationController = navigationController
    }
    
    deinit {
        print("SearchCoordinatorImpl deinit")
    }
    
    public func start() {
        let searchVM = SearchViewModel()
        let searchVC = SearchViewController(searchVM: searchVM)
        self.navigationController = UINavigationController(rootViewController: searchVC)
        self.navigationController.isNavigationBarHidden = true
        searchVC.tabBarItem = UITabBarItem(title: TabBarItem.search.title, image: UIImage(systemName: TabBarItem.search.image), tag: 1)
    }
}
