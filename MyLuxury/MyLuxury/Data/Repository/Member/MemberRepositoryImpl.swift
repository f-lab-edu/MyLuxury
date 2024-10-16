//
//  MemberRepositoryImpl.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Foundation
import Combine

public class MemberRepositoryImpl: MemberRepository {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        print("MemberRepositoryImpl init")
        self.urlSession = urlSession
    }
    
    deinit {
        print("MemberRepositoryImpl deinit")
    }
    
    /// 로그인 기능 구현 전까지 임시로 True 값을 반환하게 설정했습니다.
    /// 추후 네트워크 에러 및 DTO -> Entity 변환 과정을 이곳에서 처리하고 <Entity, Never>를 반환할 예정입니다.
    public func login() -> AnyPublisher<Bool, Never> {
        
        return Just(true).eraseToAnyPublisher()
    }
}
