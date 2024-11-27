//
//  PostUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public protocol PostUseCase {
    var postRepository: PostRepository { get }
    /// 홈 게시물 조회
    func getHomeViewData() -> AnyPublisher<HomePostData, Never>
    /// 개별 게시물 조회
    func getPostOneData(postId: String) -> AnyPublisher<Post, Never>
    /// 검색 탭 그리드 게시물 전체 조회
    func getSearchGridPostsData() -> AnyPublisher<[Post], Never>
    /// 최근 검색 게시물 조회
    func getRecentSearchPostData() -> AnyPublisher<[Post], Never>
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
    
    /// 홈 게시물 조회
    public func getHomeViewData() -> AnyPublisher<HomePostData, Never> {
        return postRepository.getHomeViewData().eraseToAnyPublisher()
    }
    
    /// 개별 게시물 조회
    public func getPostOneData(postId: String) -> AnyPublisher<Post, Never> {
        return postRepository.getPostOneData(postId: postId)
    }
    
    /// 검색 탭 그리드 게시물 전체 조회
    public func getSearchGridPostsData() -> AnyPublisher<[Post], Never> {
        return postRepository.getSearchGridPostData()
    }
    
    /// 최근 검색 게시물 조회
    public func getRecentSearchPostData() -> AnyPublisher<[Post], Never> {
        return postRepository.getRecentSearchPostData()
    }
}
