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
    func didLogin()
}

@MainActor
public protocol LoginCoordinatorDependency {
    var memberUseCase: MemberUseCase { get }
}

public class LoginCoordinatorImpl: LoginCoordinator, @preconcurrency LoginViewControllerDelegate {
    weak var delegate: LoginCoordinatorDelegate?
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
        self.delegate?.didLogin()
    }
}
