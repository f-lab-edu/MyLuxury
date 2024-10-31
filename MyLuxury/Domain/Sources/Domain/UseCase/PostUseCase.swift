//
//  PostUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public protocol PostUseCase {
    var postRepository: PostRepository { get }
    
    func getHomeViewData() -> AnyPublisher<HomePostData, Never>
}

public class PostUseCaseImpl: PostUseCase {
    
    public var postRepository: PostRepository
    private var cancellables = Set<AnyCancellable>()
    
    public init(postRepository: PostRepository) {
        print("PostUseCase init")
        self.postRepository = postRepository
    }
    
    deinit {
        print("PostUseCase deinit")
    }
    
    public func getHomeViewData() -> AnyPublisher<HomePostData, Never> {

        return postRepository.getHomeViewData().eraseToAnyPublisher()
    }
}
