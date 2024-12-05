//
//  AppCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import AuthenticationServices
import FirebaseAuth

/// 코디네이터는 앱 컴포넌트에서 생성하는 것이기 때문에
/// 앱의 생명주기 내에서 사라지지 않음.

@MainActor
public protocol Coordinator: AnyObject { }

@MainActor
public protocol AppCoordinatorDependency {
    var loginCoordinator: LoginCoordinator { get }
    var tabBarCoordinator: TabBarCoordinator { get }
}

public protocol AppCoordinator: Coordinator {
    var window: UIWindow { get set }
    func start() -> UIViewController
}

public class AppCoordinatorImpl: AppCoordinator, LoginCoordinatorDelegate, TabBarCoordinatorDelegate {
    public var window: UIWindow
    public let dependency: AppCoordinatorDependency
    public var childCoordinators: [Coordinator] = []
    
    public init(dependency: AppCoordinatorDependency, window: UIWindow) {
        print("AppCoordinator init")
        self.dependency = dependency
        self.window = window
    }
    
    public func start() -> UIViewController {
        if let _ = Auth.auth().currentUser {
            return showMainFlow()
        } else {
            return showLoginFlow()
        }
    }
    
    private func showMainFlow() -> UIViewController {
        print("메인 플로우 실행")
        let tabBarCoordinator = self.dependency.tabBarCoordinator
        tabBarCoordinator.delegate = self
        self.childCoordinators.append(tabBarCoordinator)
        return tabBarCoordinator.start()
    }
    
    private func showLoginFlow() -> UIViewController {
        print("로그인 플로우 실행")
        let loginCoordinator = self.dependency.loginCoordinator
        loginCoordinator.delegate = self
        self.childCoordinators.append(loginCoordinator)
        return loginCoordinator.start()
    }
    
    public func didLogin(_ coordinator: LoginCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.window.rootViewController = showMainFlow()
    }
    
    public func didLogout(_ coordinator: TabBarCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.window.rootViewController = showLoginFlow()
    }
}
