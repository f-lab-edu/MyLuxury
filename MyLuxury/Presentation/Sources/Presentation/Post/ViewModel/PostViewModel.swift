//
//  PostViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 11/4/24.
//

import UIKit
import Domain
import Combine

class PostViewModel {
    let postUseCase: PostUseCase
    let output: PassthroughSubject<Output, Never> = .init()
    let input: PassthroughSubject<Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    
    let postId: String
    var post: Post? = nil
    
    init(post: Post, postUseCase: PostUseCase) {
        print("PostViewModel init")
        self.postUseCase = postUseCase
        self.postId = post.post_id
    }
    
    deinit {
        print("PostViewModel deinit")
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
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
