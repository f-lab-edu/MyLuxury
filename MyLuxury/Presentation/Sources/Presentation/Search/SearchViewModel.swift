//
//  SearchViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine
import Domain

public class SearchViewModel {
    let postUseCase: PostUseCase
    private let output: PassthroughSubject<Output, Never> = .init()
    private let input: PassthroughSubject<Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    
    var searchGridPosts: [Post] = []
    
    init(postUseCase: PostUseCase) {
        print("SearchViewModel init")
        self.postUseCase = postUseCase
    }
    
    deinit {
        print("SearchViewModel deinit")
    }
    
    func transform() -> AnyPublisher<Output, Never> {
        let input = input.eraseToAnyPublisher()
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .searchBarTapped:
                self.output.send(.goToSearchResultView)
            case .searchBarCancelTapped:
                self.output.send(.goBackToSearchResultView)
            case .searchGridViewLoaded:
                getSearchGridPosts()
            case .postTapped(let post):
                self.output.send(.goToPostView(post))
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func sendInputEvent(input: Input) {
        switch input {
        case .searchBarTapped:
            self.input.send(.searchBarTapped)
        case .searchBarCancelTapped:
            self.input.send(.searchBarCancelTapped)
        case .searchGridViewLoaded:
            self.input.send(.searchGridViewLoaded)
        case .postTapped(let post):
            self.input.send(.postTapped(post))
        }
    }
    
    /// 단순히 output 인스턴스만을 반환하는 메소드이지만
    /// 외부에서는 직접 프로퍼티에 접근하는 것이 아닌 특정 메소드를 통해서만 접근할 수 있도록
    /// 제약을 거는 개념의 메소드입니다.
    func getOutputInstance() -> PassthroughSubject<Output, Never>  {
        return self.output
    }
    
    private func getSearchGridPosts() {
        postUseCase.getSearchGridPostsData()
            .sink { [weak self] searchGridPostData in
                guard let self = self else { return }
                self.searchGridPosts = searchGridPostData
                self.output.send(.getSearchGridPosts)
            }.store(in: &cancellables)
    }
}

extension SearchViewModel {
    enum Input {
        case searchBarTapped
        case searchBarCancelTapped
        case searchGridViewLoaded
        case postTapped(Post)
    }
    enum Output {
        case goToSearchResultView
        case goBackToSearchResultView
        case getSearchGridPosts
        case goToPostView(Post)
    }
}
