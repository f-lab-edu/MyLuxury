//
//  LoginViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine
import AuthenticationServices

protocol LoginViewControllerDelegate: AnyObject {
    func login()
}

public class LoginViewController: UIViewController {
    private let rootView: LoginView
        
    weak var delegate: LoginViewControllerDelegate?
    private let loginVM: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(loginVM: LoginViewModel) {
        self.loginVM = loginVM
        self.rootView = LoginView(loginVM: loginVM)
        super.init(nibName: nil, bundle: nil)
        print("LoginViewController init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LoginViewController deinit")
    }
    
    public override func loadView() {
        self.view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    private func bindData() {
        let output = loginVM.transform()
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .loginSucceed:
                    self.delegate?.login()
                case .loginFailed(let message):
                    self.showLoginFailedAlert(message: message)
                }
            }
            .store(in: &cancellables)
    }
    
    private func showLoginFailedAlert(message: String) {
        let alert = UIAlertController(title: "로그인 실패 알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
