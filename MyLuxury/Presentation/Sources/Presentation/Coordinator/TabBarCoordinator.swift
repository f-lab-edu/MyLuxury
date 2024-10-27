//
//  TabBarCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

@MainActor
protocol TabBarCoordinator: Coordinator {
    var delegate: TabBarCoordinatorDelegate? { get set }
}

@MainActor
protocol TabBarCoordinatorDelegate: AnyObject {
    func didLogout(_ coordinator: TabBarCoordinator)
}

@MainActor
public protocol TabBarCoordinatorDependency {
    var homeCoordinator: Coordinator { get }
    var searchCoordinator: Coordinator { get }
    var libraryCoordinator: Coordinator { get }
}

/// 메인 플로우의 코디네이터
public class TabBarCoordinatorImpl: TabBarCoordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    var tabBarController: UITabBarController
    weak var delegate: TabBarCoordinatorDelegate?
    var dependency: TabBarCoordinatorDependency
    
    public init(navigationController: UINavigationController, dependency: TabBarCoordinatorDependency) {
        self.navigationController = navigationController
        self.dependency = dependency
        self.tabBarController = UITabBarController()
    }
    
    deinit {
        print("TabBarCoordinatorImpl deinit")
    }
    
    public func start() {
        guard let homeCoordinator = dependency.homeCoordinator as? HomeCoordinator else { return }
        guard let searchCoordinator = dependency.searchCoordinator as? SearchCoordinator else { return }
        guard let libraryCoordinator = dependency.libraryCoordinator as? LibraryCoordinator else { return }
        homeCoordinator.start()
        searchCoordinator.start()
        libraryCoordinator.start()
        self.tabBarController.viewControllers = [
            homeCoordinator.navigationController,
            searchCoordinator.navigationController,
            libraryCoordinator.navigationController
        ]
        navigationController.viewControllers = [self.tabBarController]
    }
    
    func logout() {
        self.delegate?.didLogout(self)
    }
}
