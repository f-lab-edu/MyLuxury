//
//  MemberRepositoryImpl.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Foundation
import Combine
import Domain

public class MemberRepositoryImpl: MemberRepository {
    let urlSession: URLSession
    
    public init(urlSession: URLSession) {
        print("MemberRepositoryImpl init")
        self.urlSession = urlSession
    }
    
    deinit {
        print("MemberRepositoryImpl deinit")
    }

    public func login() -> AnyPublisher<Bool, Never> {
        return Just(true).eraseToAnyPublisher()
    }
}
