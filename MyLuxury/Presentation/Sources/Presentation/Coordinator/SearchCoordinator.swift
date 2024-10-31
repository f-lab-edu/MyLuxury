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
        searchVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabBarItem.search.image)?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: TabBarItem.search.image)?.withTintColor(.white, renderingMode: .alwaysOriginal))
    }
}
