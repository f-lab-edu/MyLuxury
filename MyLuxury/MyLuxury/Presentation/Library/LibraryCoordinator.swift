//
//  LibraryCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

class LibraryCoordinator: Coordinator {
    
    var appComponent: AppComponent
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(appComponent: AppComponent, navigationController: UINavigationController) {
        
        self.appComponent = appComponent
        self.navigationController = navigationController
    }
    
    func start() {
        
        let libraryVM = LibraryViewModel()
        let libraryVC = LibraryViewController(libraryVM: libraryVM)
        
        self.navigationController = UINavigationController(rootViewController: libraryVC)
        libraryVC.tabBarItem = UITabBarItem(title: TabBarItem.library.title, image: UIImage(systemName: TabBarItem.library.image), tag: 2)
    }
}
