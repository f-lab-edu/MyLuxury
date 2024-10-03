//
//  ExampleRepository.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

import Combine

protocol ExampleRepository {
    
    func fetchData() -> AnyPublisher<ExampleEntity, Error>
}
