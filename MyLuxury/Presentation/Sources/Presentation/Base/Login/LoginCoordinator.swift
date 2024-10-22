//
//  LoginCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Domain

@MainActor
protocol LoginCoordinator: Coordinator {
    
    var delegate: LoginCoordinatorDelegate? { get set }
}

/// AppCoordinator에게 로그인 완료 이벤트 전달
@MainActor
protocol LoginCoordinatorDelegate: AnyObject {
    
    func didLogin(_ coordinator: LoginCoordinator)
}

/// 로그인 코디네이터가 의존하는 객체 목록입니다.
@MainActor
public protocol LoginCoordinatorDependency {
    
    var memberUseCase: MemberUseCase { get }
}

public class LoginCoordinatorImpl: LoginCoordinator, @preconcurrency LoginViewControllerDelegate {
    
    public var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    
    public let dependency: LoginCoordinatorDependency
    
    weak var delegate: LoginCoordinatorDelegate?
    
    public init(navigationController: UINavigationController, dependency: LoginCoordinatorDependency) {
        
        print("LoginCoordinator init")
        
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    public func start() {
        
        let loginVM = LoginViewModel(memberUseCase: self.dependency.memberUseCase)
       
        let loginVC = LoginViewController(loginVM: loginVM)
        
        loginVC.delegate = self
        
        self.navigationController.viewControllers = [loginVC]
    }
    
    /// AppCoordinator에게 로그인 완료 후 메인 플로우로 화면 전환 요청
    @MainActor
    func login() {
        
        self.delegate?.didLogin(self)
    }
}
