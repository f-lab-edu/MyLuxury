//
//  MemberUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public protocol MemberUseCase {
    var memberRepository: MemberRepository { get }
    func appleLogin() -> AnyPublisher<String, Never>
    func logout() -> Bool
}

public class MemberUseCaseImpl: MemberUseCase {
    public var memberRepository: MemberRepository
    private let cancellabes = Set<AnyCancellable>()
    
    public init(memberRepository: MemberRepository) {
        print("MemberUseCase init")
        self.memberRepository = memberRepository
    }
    
    deinit {
        print("MemberUseCase deinit")
    }

    public func appleLogin() -> AnyPublisher<String, Never> {
        return memberRepository.appleLogin()
    }
    
    public func logout() -> Bool {
        return memberRepository.logout()
    }
}
