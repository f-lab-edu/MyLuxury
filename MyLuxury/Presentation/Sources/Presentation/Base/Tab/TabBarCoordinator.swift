//
//  TabBarCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

@MainActor
public protocol TabBarCoordinator: Coordinator {
    var delegate: TabBarCoordinatorDelegate? { get set }
    func start() -> UIViewController
}

@MainActor
public protocol TabBarCoordinatorDelegate: AnyObject {
    func didLogout(_ coordinator: TabBarCoordinator)
}

@MainActor
public protocol TabBarCoordinatorDependency {
    var homeCoordinator: HomeCoordinator { get }
    var searchCoordinator: SearchCoordinator { get }
    var libraryCoordinator: LibraryCoordinator { get }
}

public class TabBarCoordinatorImpl: TabBarCoordinator, @preconcurrency LibraryCoordinatorDelegate {
    public weak var delegate: TabBarCoordinatorDelegate?
    private var dependency: TabBarCoordinatorDependency
    var childCoordinators: [Coordinator] = []
    
    public init(dependency: TabBarCoordinatorDependency) {
        print("TabBarCoordinatorImpl init")
        self.dependency = dependency
    }
    
    public func start() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .white
        let homeCoordinator = self.dependency.homeCoordinator
        let searchCoordinator = self.dependency.searchCoordinator
        let libraryCoordinator = self.dependency.libraryCoordinator
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(libraryCoordinator)
        libraryCoordinator.delegate = self
        tabBarController.viewControllers = [
            homeCoordinator.start(),
            searchCoordinator.start(),
            libraryCoordinator.start()
        ]
        return tabBarController
    }
 
    @MainActor
    public func logout() {
        NotificationCenter.default.post(name: .didLogout, object: nil)
        self.childCoordinators.removeAll()
        self.delegate?.didLogout(self)
    }
}
