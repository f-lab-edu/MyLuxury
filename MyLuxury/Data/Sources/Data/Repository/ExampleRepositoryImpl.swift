//
//  ExampleRepositoryImpl.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

import Foundation
import Combine
import Domain

//public class ExampleRepositoryImpl: ExampleRepository {
//    
//    /// NetworkManager 사용 예정
//    func fetchData() -> AnyPublisher<ExampleEntity, any Error> {
//        
//        let url = URL(string: "localhost:8080/")!
//        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            /// 네트워크 실패 시 실행되는 연산자
//            .catch { error in
//                return Fail(error: error).eraseToAnyPublisher()
//            }
//            .map { $0.data }
//            .decode(type: ExampleRespDTO.self, decoder: JSONDecoder())
//            .map { $0.toExampleEntity() }
//            .eraseToAnyPublisher()
//    }
//}
