//
//  MemberRepository.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public protocol MemberRepository {
    func appleLogin() -> AnyPublisher<String, Never>
    func logout() -> Bool
}
