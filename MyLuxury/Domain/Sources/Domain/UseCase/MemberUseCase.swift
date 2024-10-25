//
//  MemberUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public protocol MemberUseCase {
    var memberRepository: MemberRepository { get }
    func login() -> AnyPublisher<Bool, Never>
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

    /// 임시 로그인 메소드
    public func login() -> AnyPublisher<Bool, Never> {
        
        return memberRepository.login()
    }
}
