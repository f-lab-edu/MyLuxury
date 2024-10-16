//
//  AppCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

/// 코디네이터 패턴을 통해 화면 전환을 합니다.
public protocol Coordinator: AnyObject {
    
    /// 뷰모델 및 뷰 컨트롤러에 UseCase를 주입하기 위해 모든 코디네이터는 생성한 AppComponent를 프로퍼티로 가지며
    /// AppCoordinator에서 최초 생성한 AppComponent를 이어받습니다.
    var appComponent: AppComponent { get set }
    /// 각 코디네이터는 하나의 UINavigationController를 가집니다.
    var navigationController: UINavigationController { get set }
    /// 자식 코디네이터를 추적하기 위한 프로퍼티. 대부분의 경우 이 배열은 하나의 자식 코디네이터만을 가집니다.
    var childCoordinators: [Coordinator] { get set }
    /// 로직을 시작하기 위한 메소드
    func start()
}

/// 앱의 실행과 생명주기를 같이 하는 유일한 코디네이터입니다.
/// 로그인 및 탭바 델리게이트를 위임함으로써 로그인과 메인 플로우 화면 전환을 담당합니다.
public class AppCoordinator: Coordinator, LoginCoordinatorDelegate, TabBarCoordinatorDelegate {
    
    public var appComponent: AppComponent
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        
        print("AppCoordinator init")
        
        /// 코디네이터가 SceneDelegate에서 생성될 때 AppComponent도 함께 생성합니다.
        self.appComponent = AppComponent()
        /// SceneDelegate에서 생성된 UINavigationController 인스턴스를 넘겨받습니다.
        self.navigationController = navigationController
    }
    
    public func start() {
        
        /// 앱이 처음 실행되었을 때 UserDefaults의 로그인 여부 값이 true일 경우 메인 플로우, false일 경우 로그인 플로우를 실행합니다.
        UserDefaults.standard.bool(forKey: "isLogin") ? showMainFlow() : showLoginFlow()
    }
    
    /// 메인 플로우 실행 메소드
    public func showMainFlow() {
        
        print("메인 플로우 실행")

        let coordinator = TabBarCoordinator(appComponent: self.appComponent, navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    /// 로그인 플로우 실행 메소드
    public func showLoginFlow() {
        
        print("로그인 플로우 실행")
        
        /// SceneDelegate로부터 받아온 navigationController를 coordinator에 넘겨줍니다.
        let coordinator = LoginCoordinator(navigationController: self.navigationController, appComponent: self.appComponent)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
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
