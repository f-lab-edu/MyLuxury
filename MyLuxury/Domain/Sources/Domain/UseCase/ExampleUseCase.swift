//
//  ExampleUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

import Combine

class ExampleUseCase {
    
    private let exampleRepository: ExampleRepository
    private var cancellables = Set<AnyCancellable>()
    
    /// 생성자 주입
    init(exampleRepository: ExampleRepository) {
        self.exampleRepository = exampleRepository
    }
    
    func fetchData() -> AnyPublisher<ExampleEntity, Never> {

        exampleRepository.fetchData()
            /// 에러 처리
            .catch { error in
                print("네트워크 에러: \(error.localizedDescription)")
                
                return Just(ExampleEntity(value: "기본값")).eraseToAnyPublisher()
                
                /// 값을 방출하지 않고 그대로 종료
//                return Empty<ExampleEntity, Never>().eraseToAnyPublisher()
            }
            .map { entity in
                /// 비즈니스 로직 처리
                return entity
            }
            .eraseToAnyPublisher()
    }
}
