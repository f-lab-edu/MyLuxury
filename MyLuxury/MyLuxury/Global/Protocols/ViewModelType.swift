//
//  ViewModelType.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

import Combine

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
}
