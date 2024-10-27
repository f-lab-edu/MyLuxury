//
//  LibraryCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

public protocol LibraryCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}

public class LibraryCoordinatorImpl: LibraryCoordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    
    public init(navigationController: UINavigationController) {
        print("LibraryCoordinatorImpl init")
        self.navigationController = navigationController
    }
    
    deinit {
        print("LibraryCoordinatorImpl deinit")
    }
    
    public func start() {
        let libraryVM = LibraryViewModel()
        let libraryVC = LibraryViewController(libraryVM: libraryVM)
        self.navigationController = UINavigationController(rootViewController: libraryVC)
        libraryVC.tabBarItem = UITabBarItem(title: TabBarItem.library.title, image: UIImage(systemName: TabBarItem.library.image), tag: 2)
    }
}
