//
//  AppCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import AuthenticationServices
import FirebaseAuth

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
        /// Firebase는 기본적으로 사용자의 인증 상태를 유지
        /// 앱이 새로 설치되었거나 인증 토큰이 만료되면 currentUser가 nil이 되면서 로그인 플로우로 진행
        /// 사용자가 Auth.auth().signOut()을 호출할 경우 로그아웃 상태가 되므로 currentUser가 nil이 됩니다.
        /// 새로운 사용자가 로그인하면, currentUser는 새롭게 로그인한 사용자의 정보를 들고 있습니다.
        if let user = Auth.auth().currentUser {
            /// 사용자가 로그인 상태라면 메인 화면으로 이동
            showMainFlow()
        } else {
            /// 사용자가 로그아웃 상태라면
            showLoginFlow()
        }
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
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showMainFlow()
    }
    
    func didLogout(_ coordinator: TabBarCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showLoginFlow()
    }
}
