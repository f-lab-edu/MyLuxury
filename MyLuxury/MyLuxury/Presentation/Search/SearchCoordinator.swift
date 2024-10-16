//
//  SearchCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    var appComponent: AppComponent
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(appComponent: AppComponent, navigationController: UINavigationController) {
        
        self.appComponent = appComponent
        self.navigationController = navigationController
    }
    
    func start() {
        
        let searchVM = SearchViewModel()
        let searchVC = SearchViewController(searchVM: searchVM)
        self.navigationController = UINavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = UITabBarItem(title: TabBarItem.search.title, image: UIImage(systemName: TabBarItem.search.image), tag: 1)
    }
}
