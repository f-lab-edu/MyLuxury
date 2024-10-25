//
//  MemberRepository.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public protocol MemberRepository {
    /// 임시 로그인 메소드
    func login() -> AnyPublisher<Bool, Never>
}
