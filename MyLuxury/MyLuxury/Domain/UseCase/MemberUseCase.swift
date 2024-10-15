//
//  MemberUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public class MemberUseCase {
    
    private let memberRepository: MemberRepository
    
    init(memberRepository: MemberRepository) {
        self.memberRepository = memberRepository
    }
}
