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
public class TabBarCoordinatorImpl: TabBarCoordinator, LibraryCoordinatorDelegate {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    var tabBarController: UITabBarController
    weak var delegate: TabBarCoordinatorDelegate?
    var dependency: TabBarCoordinatorDependency
    
    public init(navigationController: UINavigationController, dependency: TabBarCoordinatorDependency) {
        self.navigationController = navigationController
        self.dependency = dependency
        self.tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .white
    }
    
    deinit {
        print("TabBarCoordinatorImpl deinit")
    }
    
    public func start() {
        guard let homeCoordinator = dependency.homeCoordinator as? HomeCoordinator else { return }
        guard let searchCoordinator = dependency.searchCoordinator as? SearchCoordinator else { return }
        guard let libraryCoordinator = dependency.libraryCoordinator as? LibraryCoordinator else { return }
        libraryCoordinator.delegate = self
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
    
    public func logout() {
        /// 기존 뷰 계층 초기화
        self.navigationController.viewControllers = []
        /// 기존에 있던 Home, Search, Library 관련 인스턴스에 대한 참조를 끊음.
        tabBarController.viewControllers = nil
        self.delegate?.didLogout(self)
    }
}
