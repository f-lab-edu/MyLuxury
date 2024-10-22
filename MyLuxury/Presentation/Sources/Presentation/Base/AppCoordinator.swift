//
//  AppCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

/// 코디네이터 패턴을 통해 화면 전환을 합니다.

@MainActor
public protocol Coordinator: AnyObject {
    
    /// 각 코디네이터는 하나의 UINavigationController를 가집니다.
    var navigationController: UINavigationController { get set }
    /// 자식 코디네이터를 추적하기 위한 프로퍼티. 대부분의 경우 이 배열은 하나의 자식 코디네이터만을 가집니다.
    var childCoordinators: [Coordinator] { get set }
    /// 로직을 시작하기 위한 메소드
    func start()
}

@MainActor
public protocol AppCoordinatorDependency {
    
    var loginCoordinator: Coordinator { get }
    var tabBarCoordinator: Coordinator { get }
}

/// 앱의 실행과 생명주기를 같이 하는 유일한 코디네이터입니다.
/// 로그인 및 탭바 델리게이트를 위임함으로써 로그인과 메인 플로우 화면 전환을 담당합니다.
public class AppCoordinator: Coordinator, LoginCoordinatorDelegate, TabBarCoordinatorDelegate {

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    
    public let dependency: AppCoordinatorDependency
    
    public init(navigationController: UINavigationController, dependency: AppCoordinatorDependency) {
        
        print("AppCoordinator init")

        /// SceneDelegate에서 생성된 UINavigationController 인스턴스를 넘겨받습니다.
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    public func start() {
        
        /// 앱이 처음 실행되었을 때 UserDefaults의 로그인 여부 값이 true일 경우 메인 플로우, false일 경우 로그인 플로우를 실행합니다.
        UserDefaults.standard.bool(forKey: "isLogin") ? showMainFlow() : showLoginFlow()
    }
    
    /// 메인 플로우 실행 메소드
    public func showMainFlow() {
        
        print("메인 플로우 실행")

        /// TabBarCoordinator 프로토콜에 의존하도록 설계
        /// AppComponent로부터 실제 객체를 주입받습니다.
        guard let tabBarCoordinator = self.dependency.tabBarCoordinator as? TabBarCoordinator else { return }
        
        /// 현재 탭바 로그인 코디네이터의 delegate는 weak로 선언되어 있습니다.
        tabBarCoordinator.delegate = self
        
        tabBarCoordinator.start()
        self.childCoordinators.append(tabBarCoordinator)
    }
    
    /// 로그인 플로우 실행 메소드
    public func showLoginFlow() {
        
        print("로그인 플로우 실행")

        /// LoginCoordinator 프로토콜에 의존하도록 설계
        /// AppComponent로부터 실제 객체를 주입받습니다.
        guard let loginCoordinator = self.dependency.loginCoordinator as? LoginCoordinator else { return }
        
        /// 현재 로그인 코디네이터의 delegate는 weak로 선언되어 있습니다.
        loginCoordinator.delegate = self
        
        loginCoordinator.start()
        self.childCoordinators.append(loginCoordinator)
    }
    
    /// LoginCoordinator가 실행하는 메소드. 로그인 코디네이터를 없애고 메인 플로우 코디네이터를 실행합니다.
    func didLogin(_ coordinator: LoginCoordinator) {
        
        /// 로그인 상태를 true로 바꿉니다.
        UserDefaults.standard.set(true, forKey: "isLogin")
        /// AppCoordinator의 자식 코디네이터에서 LoginCoordinator를 삭제합니다.
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        /// 로그인 완료 후 메인 플로우로 전환합니다.
        self.showMainFlow()
    }
    
    func didLogout(_ coordinator: TabBarCoordinator) {
        
        /// 로그인 상태를 false로 바꿉니다.
        UserDefaults.standard.set(false, forKey: "isLogin")
        /// AppCoordinator의 자식 코디네이터에서 TabBarCoordinator를 삭제합니다.
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        /// 로그아웃 완료 후 로그인 플로우로 전환합니다.
        self.showLoginFlow()
    }
}
