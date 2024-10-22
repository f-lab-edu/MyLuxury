//
//  ExampleRepository.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

import Combine

public protocol ExampleRepository {
    
    func fetchData() -> AnyPublisher<ExampleEntity, Error>
}
