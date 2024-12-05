//
//  LibraryViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine
import Domain

protocol LibraryViewModelDelegate: AnyObject {
    func goToLoginPage()
}

class LibraryViewModel {
    private let memberUseCase: MemberUseCase
    private let output: PassthroughSubject<Output, Never> = .init()
    private let input: PassthroughSubject<Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    weak var delegate: LibraryViewModelDelegate?
    
    init(memberUseCase: MemberUseCase) {
        print("LibraryViewModel init")
        self.memberUseCase = memberUseCase
    }
    
    deinit {
        print("LibraryViewModel deinit")
    }
    
    func transform() -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .logoutBtnTapped:
                self.logout()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func sendInputEvent(input: Input) {
        switch input {
        case .logoutBtnTapped:
            self.input.send(.logoutBtnTapped)
        }
    }
    
    private func logout() {
        let isSucceed = memberUseCase.logout()
        if isSucceed {
            self.output.send(.logoutSuccess)
        } else {
            self.output.send(.logoutFailed("로그아웃에 실패했습니다. 잠시 후 다시 시도해주세요."))
        }
    }
}

extension LibraryViewModel {
    enum Input {
        case logoutBtnTapped
    }
    enum Output {
        case logoutSuccess
        case logoutFailed(String)
    }
}
