//
//  LoginCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Domain

@MainActor
public protocol LoginCoordinator: Coordinator {
    var delegate: LoginCoordinatorDelegate? { get set }
    func start() -> UIViewController
}

@MainActor
public protocol LoginCoordinatorDelegate: AnyObject {
    func didLogin(_ coordinator: LoginCoordinator)
}

@MainActor
public protocol LoginCoordinatorDependency {
    var memberUseCase: MemberUseCase { get }
}

public class LoginCoordinatorImpl: LoginCoordinator, @preconcurrency LoginViewControllerDelegate {
    public weak var delegate: LoginCoordinatorDelegate?
    private let dependency: LoginCoordinatorDependency
    
    public init(dependency: LoginCoordinatorDependency) {
        print("LoginCoordinator init")
        self.dependency = dependency
    }
    
    public func start() -> UIViewController {
        let loginVM = LoginViewModel(memberUseCase: self.dependency.memberUseCase)
        let loginVC = LoginViewController(loginVM: loginVM)
        loginVC.delegate = self
        return loginVC
    }
    
    @MainActor
    func login() {
        self.delegate?.didLogin(self)
    }
}
