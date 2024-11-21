//
//  LoginViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine
import Domain
import AuthenticationServices

final class LoginViewModel: NSObject {
    private let memberUseCase: MemberUseCase
    private let output: PassthroughSubject<Output, Never> = .init()
    private let input: PassthroughSubject<Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(memberUseCase: MemberUseCase) {
        print("LoginViewModel init")
        self.memberUseCase = memberUseCase
    }
    
    deinit {
        print("LoginViewModel deinit")
    }
    
    func transform() -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .loginBtnTap:
                self.login()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func sendInputEvent(input: Input) {
        switch input {
        case .loginBtnTap:
            self.input.send(.loginBtnTap)
        }
    }
    
    private func login() {
        memberUseCase.appleLogin()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.output.send(.loginFailed("로그인에 실패했습니다. 잠시 후 다시 시도해주세요."))
                }
            }, receiveValue: { [weak self] userId in
                guard let self = self else { return }
                self.output.send(.loginSucceed)
            })
            .store(in: &cancellables)
    }
}


extension LoginViewModel {
    enum Input {
        case loginBtnTap
    }
    
    enum Output {
        case loginSucceed
        case loginFailed(String)
    }
}
