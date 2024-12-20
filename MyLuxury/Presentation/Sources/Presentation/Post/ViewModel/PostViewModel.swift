//
//  PostViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 11/4/24.
//

import UIKit
import Domain
import Combine

protocol PostViewModelDelegate: AnyObject {
    func goToBackScreen()
}

class PostViewModel {
    let postUseCase: PostUseCase
    private let output: PassthroughSubject<Output, Never> = .init()
    private let input: PassthroughSubject<Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    weak var delegate: PostViewModelDelegate?
    
    let postId: String
    var post: Post? = nil
    
    init(postId: String, postUseCase: PostUseCase) {
        print("PostViewModel init")
        self.postUseCase = postUseCase
        self.postId = postId
    }
    
    deinit {
        print("PostViewModel deinit")
    }
    
    func transform() -> AnyPublisher<Output, Never> {
        let input = input.eraseToAnyPublisher()
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .goBackBtnTapped:
                self.output.send(.goToBackScreen)
            case .viewLoaded:
                self.getPostOneData(postId: self.postId)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func sendInputEvent(input: Input) {
        switch input {
        case .goBackBtnTapped:
            self.input.send(.goBackBtnTapped)
        case .viewLoaded:
            self.input.send(.viewLoaded)
        }
    }

    func getPostOneData(postId: String) {
        postUseCase.getPostOneData(postId: postId)
            .sink { [weak self] postData in
                guard let self = self else { return }
                self.post = postData
                self.output.send(.getPostOneData)
            }
            .store(in: &cancellables)
    }
}

extension PostViewModel {
    enum Input {
        case goBackBtnTapped
        case viewLoaded
    }
    enum Output {
        case goToBackScreen
        case getPostOneData
    }
}
