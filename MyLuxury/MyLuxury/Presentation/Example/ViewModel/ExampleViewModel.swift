//
//  ExampleViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

import Combine

final class ExampleViewModel {
    
    enum Input {
        
        case viewDidAppear
    }
    
    enum Output {
        
        case fetchData(value: String)
    }
    
    private let exampleUseCase = ExampleUseCase()
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        
        input.sink { event in
            
            switch event {
                
            case .viewDidAppear:
                self.fetchData()
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func fetchData() {
        
        exampleUseCase.fetchData().sink { entity in
            
            self.output.send(.fetchData(value: entity.value))
        }.store(in: &cancellables)
    }
}
