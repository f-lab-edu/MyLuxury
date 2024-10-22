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
    
    /// 로그인 메소드
    /// (필요하다면) 로그인 관련 비즈니스 로직을 처리할 메소드입니다.
    public func login() -> AnyPublisher<Bool, Never> {
        
        return memberRepository.login()
    }
}
