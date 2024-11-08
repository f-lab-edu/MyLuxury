//
//  AppCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

@MainActor
public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

@MainActor
public protocol AppCoordinatorDependency {
    var loginCoordinator: Coordinator { get }
    var tabBarCoordinator: Coordinator { get }
}

public class AppCoordinator: Coordinator, LoginCoordinatorDelegate, TabBarCoordinatorDelegate {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    public let dependency: AppCoordinatorDependency
    
    public init(navigationController: UINavigationController, dependency: AppCoordinatorDependency) {
        print("AppCoordinator init")
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    public func start() {
        UserDefaults.standard.bool(forKey: "isLogin") ? showMainFlow() : showLoginFlow()
    }
    
    private func showMainFlow() {
        print("메인 플로우 실행")
        guard let tabBarCoordinator = self.dependency.tabBarCoordinator as? TabBarCoordinator else { return }
        tabBarCoordinator.delegate = self
        tabBarCoordinator.start()
        self.childCoordinators.append(tabBarCoordinator)
    }
    
    private func showLoginFlow() {
        print("로그인 플로우 실행")
        guard let loginCoordinator = self.dependency.loginCoordinator as? LoginCoordinator else { return }
        loginCoordinator.delegate = self
        loginCoordinator.start()
        self.childCoordinators.append(loginCoordinator)
    }

    func didLogin(_ coordinator: LoginCoordinator) {
        UserDefaults.standard.set(true, forKey: "isLogin")
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showMainFlow()
    }
    
    func didLogout(_ coordinator: TabBarCoordinator) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showLoginFlow()
    }
}
