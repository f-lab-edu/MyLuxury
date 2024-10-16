//
//  LoginViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

final class LoginViewModel {
    
    let memberUseCase: MemberUseCase
    let output: PassthroughSubject<Output, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    
    init(memberUseCase: MemberUseCase) {
        print("LoginViewModel init")
        self.memberUseCase = memberUseCase
    }
    
    deinit {
        print("LoginViewModel deinit")
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        
        input.sink { [weak self] event in
            
            switch event {
        
            case .loginBtnTap:  /// 로그인 버튼이 눌렸을 경우 로그인 요청 메소드 실행
                self!.login()
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    func login() {
        
        /// memberUseCase.login()을 구독하고 결과를 output 퍼블리셔에 보냅니다.
        memberUseCase.login().sink { value in
            
            self.output.send(.loginSucceed(value: value))
            
            /// 해당 메소드가 종료되더라도 구독을 유지합니다.
        }.store(in: &cancellables)
    }
}

extension LoginViewModel {
    
    enum Input {
        
        case loginBtnTap
    }
    
    enum Output {
        
        case loginSucceed(value: Bool)
    }
}
