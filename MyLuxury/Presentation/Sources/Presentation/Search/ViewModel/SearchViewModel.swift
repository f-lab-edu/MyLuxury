//
//  SearchViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine
import Domain

protocol SearchViewModelDelegate: AnyObject {
    func goToSearchResultView(searchVM: SearchViewModel)
    func goToPostView(postId: String)
    func goBackToResultGridView()
}

class SearchViewModel {
    let postUseCase: PostUseCase
    private let output: PassthroughSubject<Output, Never> = .init()
    private let input: PassthroughSubject<Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    weak var delegate: SearchViewModelDelegate?
    
    var searchGridPosts: [Post] = []
    var recentSearchPosts: [Post] = []
    
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
            case .postTappedFromGrid(let post):
                self.output.send(.goToPostViewFromGrid(post))
            case .postTappedFromRecentSearch(let post):
                self.output.send(.goToPostViewFromSearch(post))
            case .searchResultViewLoaded:
                getRecentSearchPosts()
            case .deleteRecentSearchPostBtnTapped(let index):
                self.output.send(.removeRecentSearchPost(index))
            case .searchResultViewDisappeared:
                saveRecentSearchPosts()
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
        case .postTappedFromGrid(let post):
            self.input.send(.postTappedFromGrid(post))
        case .postTappedFromRecentSearch(let post):
            self.input.send(.postTappedFromRecentSearch(post))
        case .searchResultViewLoaded:
            self.input.send(.searchResultViewLoaded)
        case .deleteRecentSearchPostBtnTapped(let index):
            self.input.send(.deleteRecentSearchPostBtnTapped(index))
        case .searchResultViewDisappeared:
            self.input.send(.searchResultViewDisappeared)
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
    
    private func getRecentSearchPosts() {
        postUseCase.getRecentSearchPostData()
            .sink { [weak self] recentSearchPostData in
                guard let self = self else { return }
                self.recentSearchPosts = recentSearchPostData
                self.output.send(.getRecentSearchPosts)
            }.store(in: &cancellables)
    }
    
    private func saveRecentSearchPosts() {
        print("최근 검색 기록 저장 api 호출중")
        // self.output.send(.saveRecentSearchPosts)
    }
}

extension SearchViewModel {
    enum Input {
        case searchBarTapped
        case searchBarCancelTapped
        case searchGridViewLoaded
        case postTappedFromGrid(String)
        case searchResultViewLoaded
        case postTappedFromRecentSearch(String)
        case deleteRecentSearchPostBtnTapped(Int)
        case searchResultViewDisappeared
    }
    enum Output {
        case goToSearchResultView
        case goBackToSearchResultView
        case getSearchGridPosts
        case goToPostViewFromGrid(String)
        case getRecentSearchPosts
        case goToPostViewFromSearch(String)
        case removeRecentSearchPost(Int)
        case saveRecentSearchPosts
    }
}
