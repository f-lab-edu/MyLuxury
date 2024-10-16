//
//  LoginCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

/// AppCoordinator에게 로그인 완료 이벤트 전달
protocol LoginCoordinatorDelegate {
    
    func didLogin(_ coordinator: LoginCoordinator)
}

public class LoginCoordinator: Coordinator, LoginViewControllerDelegate {
    
    public var appComponent: AppComponent
    
    public var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    
    var delegate: LoginCoordinatorDelegate?
    
    init(navigationController: UINavigationController, appComponent: AppComponent) {
        self.navigationController = navigationController
        self.appComponent = appComponent
    }
    
    public func start() {
        
        let loginVM = LoginViewModel(memberUseCase: appComponent.memberUseCase)
        let loginVC = LoginViewController(loginVM: loginVM)
        
        loginVC.delegate = self
        
        self.navigationController.viewControllers = [loginVC]
    }
    
    /// AppCoordinator에게 로그인 완료 후 메인 플로우로 화면 전환 요청
    func login() {
        
        self.delegate?.didLogin(self)
    }
}
