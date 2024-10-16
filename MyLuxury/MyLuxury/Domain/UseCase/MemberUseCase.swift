//
//  MemberUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public class MemberUseCase {
    
    private let memberRepository: MemberRepository
    private let cancellabes = Set<AnyCancellable>()
    
    init(memberRepository: MemberRepository) {
        self.memberRepository = memberRepository
    }
    
    /// 로그인 메소드
    /// (필요하다면) 로그인 관련 비즈니스 로직을 처리할 메소드입니다.
    func login() -> AnyPublisher<Bool, Never> {
        
        return memberRepository.login()
    }
}
