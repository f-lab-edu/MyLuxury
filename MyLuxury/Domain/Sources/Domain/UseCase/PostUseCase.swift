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
    func getPostOneData(postId: String) -> AnyPublisher<Post, Never>
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
    
    /// 홈 화면 데이터 조회
    public func getHomeViewData() -> AnyPublisher<HomePostData, Never> {
        return postRepository.getHomeViewData().eraseToAnyPublisher()
    }
    
    /// 개별 게시물 조회
    public func getPostOneData(postId: String) -> AnyPublisher<Post, Never> {
        return postRepository.getPostOneData(postId: postId)
    }
}
