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
public protocol Coordinator: AnyObject {
    func start() -> UIViewController
}

@MainActor
public protocol AppCoordinatorDependency {
    var loginCoordinator: Coordinator { get }
    var tabBarCoordinator: Coordinator { get }
}

public class AppCoordinator: Coordinator, LoginCoordinatorDelegate, TabBarCoordinatorDelegate {
    public var window: UIWindow
    public let dependency: AppCoordinatorDependency
    
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
        let tabBarCoordinator = self.dependency.tabBarCoordinator as! TabBarCoordinator
        tabBarCoordinator.delegate = self
        return tabBarCoordinator.start()
    }
    
    private func showLoginFlow() -> UIViewController {
        print("로그인 플로우 실행")
        let loginCoordinator = self.dependency.loginCoordinator as! LoginCoordinator
        loginCoordinator.delegate = self
        return loginCoordinator.start()
    }
    
    func didLogin() {
        self.window.rootViewController = showMainFlow()
    }
    
    func didLogout() {
        self.window.rootViewController = showLoginFlow()
    }
}
