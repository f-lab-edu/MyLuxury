//
//  LoginViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

protocol LoginViewControllerDelegate: AnyObject {
    func login()
}

class LoginViewController: UIViewController {
    private var loginBtn: UIButton = {
      
        let loginBtn = UIButton()
        loginBtn.setTitle("로그인", for: .normal)
        loginBtn.tintColor = .blue
        loginBtn.addTarget(self, action: #selector(loginBtnDidTap), for: .touchUpInside)
        return loginBtn
    }()
    
    weak var delegate: LoginViewControllerDelegate?
    private let loginVM: LoginViewModel
    private let input: PassthroughSubject<LoginViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(loginVM: LoginViewModel) {
        print("LoginViewController init")
        self.loginVM = loginVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LoginViewController deinit")
    }
    
    override func viewDidLoad() {
        
        view.addSubview(loginBtn)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginBtn.widthAnchor.constraint(equalToConstant: 200),
            loginBtn.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        bind()
    }
    
    private func bind() {
        let output = loginVM.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .loginSucceed(let value):
                    if value {
                        self!.delegate?.login()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    @objc
    func loginBtnDidTap() {
        input.send(.loginBtnTap)
    }
}
