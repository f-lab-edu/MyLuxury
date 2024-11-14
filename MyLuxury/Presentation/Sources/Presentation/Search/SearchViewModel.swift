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
    let output: PassthroughSubject<Output, Never> = .init()
    let input: PassthroughSubject<Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    
    var searchGridPosts: [Post] = []
    
    init(postUseCase: PostUseCase) {
        print("SearchViewModel init")
        self.postUseCase = postUseCase
    }
    
    deinit {
        print("SearchViewModel deinit")
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
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
