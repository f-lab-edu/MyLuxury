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

@MainActor
protocol LoginCoordinatorDelegate: AnyObject {
    func didLogin(_ coordinator: LoginCoordinator)
}

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
    
    @MainActor
    func login() {
        self.delegate?.didLogin(self)
    }
}
