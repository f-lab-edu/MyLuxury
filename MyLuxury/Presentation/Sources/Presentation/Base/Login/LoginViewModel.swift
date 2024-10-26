//
//  LoginViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine
import Domain

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
            case .loginBtnTap:
                self!.login()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func login() {
        memberUseCase.login().sink { value in
            self.output.send(.loginSucceed(value: value))
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
