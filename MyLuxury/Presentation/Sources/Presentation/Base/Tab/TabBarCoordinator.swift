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

/// 로그아웃 시 메인 플로우에서 로그인 플로우로 가는 것을 AppCoordinator에 위임하기 위한 델리게이트입니다.
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
    /// 메인 플로우의 코디네이터네 탭바 컨트롤러를 두고 탭마다 코디네이터를 따로 두도록 설계합니다.
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
    
    /// 로그아웃 시 실행되는 메소드로 추후 로그아웃 ViewController의 위임 메소드로써 실행됩니다.
    func logout() {
        
        self.delegate?.didLogout(self)
    }
}
