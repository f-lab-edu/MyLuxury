//
//  LoginViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

/// LoginCoordinator 에게 로그인 이벤트 전달
protocol LoginViewControllerDelegate {
    
    func login()
}

class LoginViewController: UIViewController {
    
    var loginBtn: UIButton = {
      
        let loginBtn = UIButton()
        loginBtn.setTitle("로그인", for: .normal)
        loginBtn.tintColor = .blue
        loginBtn.addTarget(self, action: #selector(loginBtnDidTap), for: .touchUpInside)
        return loginBtn
    }()
    
    var delegate: LoginViewControllerDelegate?
    let loginVM: LoginViewModel
    let input: PassthroughSubject<LoginViewModel.Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    
    init(loginVM: LoginViewModel) {
        self.loginVM = loginVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LoginController deinit")
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
    }
    
    /// 로그인 성공 여부에 따른 메인 플로우로 이동하는 메소드입니다.
    func goToMainFlow() {
        
        let output = loginVM.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { event in
                
                switch event {
                 
                case .loginSucceed(let value):
                    
                    /// 로그인 성공 응답을 받았다면
                    if value {
                        /// 코디네이터를 통한 화면 전환
                        self.delegate?.login()
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
