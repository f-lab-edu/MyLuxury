//
//  LoginViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

/// LoginCoordinator 에게 로그인 이벤트 전달
protocol LoginViewControllerDelegate: AnyObject {
    
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
    
    /// LoginCoordinator를 약한 참조함으로써 로그인 플로우가 종료되었을 때
    /// LoginCoordinator가 메모리에서 삭제되도록 했습니다.
    weak var delegate: LoginViewControllerDelegate?
    let loginVM: LoginViewModel
    let input: PassthroughSubject<LoginViewModel.Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    
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
    
    func bind() {
        
        let output = loginVM.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                
                switch event {
                 
                case .loginSucceed(let value):
                    
                    /// 로그인 성공 응답을 받았다면
                    if value {
                        /// 코디네이터를 통한 화면 전환
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
