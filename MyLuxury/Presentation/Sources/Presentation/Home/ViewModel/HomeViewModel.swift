//
//  HomeViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Foundation
import Combine
import Domain

protocol HomeViewModelDelegate: AnyObject {
    func goToPost(postId: String)
}

class HomeViewModel {
    private let postUseCase: PostUseCase
    private let output: PassthroughSubject<Output, Never> = .init()
    private let input: PassthroughSubject<Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    var homePostData: HomePostViewDataGroup? = nil
    weak var delegate: HomeViewModelDelegate?
    
    init(postUseCase: PostUseCase) {
        print("HomeViewModel init")
        self.postUseCase = postUseCase
    }
    
    deinit {
        print("HomeViewModel deinit")
    }
    
    func transform() -> AnyPublisher<Output, Never> {
        let input = input.eraseToAnyPublisher()
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .viewLoaded:
                self.getHomeViewData()
            case .viewReload:
                self.getHomeViewData()
            case .postTapped(let post):
                self.output.send(.goToPost(post))
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func sendInputEvent(input: Input) {
        switch input {
        case .viewLoaded:
            self.input.send(.viewLoaded)
        case .viewReload:
            self.input.send(.viewReload)
        case .postTapped(let post):
            self.input.send(.postTapped(post))
        }
    }
    
    func getHomeViewData() {
        postUseCase.getHomeViewData()
            .sink { [weak self] homeData in
                guard let self = self else { return }
                self.homePostData = convertHomePostViewDataGroup(homeData: homeData)
                self.output.send(.getHomePostData)
            }.store(in: &cancellables)
    }
    
    func convertHomePostViewDataGroup(homeData: HomePostData) -> HomePostViewDataGroup {
        
        func convertPostArray(posts: [Post]?) -> [HomePostViewData]? {
            posts?.map { post in
                HomePostViewData(
                    post_id: post.post_id,
                    postTitle: post.postTitle,
                    postThumbnailImage: post.postThumbnailImage,
                    postCategory: post.postCategory)
            }
        }
        
        var dataGroup = HomePostViewDataGroup()
        dataGroup.sectionIndex = homeData.sectionIndex
        
        if let post = homeData.todayPickPostData {
            dataGroup.todayPickPostData = HomePostViewData(
                post_id: post.post_id,
                postTitle: post.postTitle,
                postThumbnailImage: post.postThumbnailImage,
                postCategory: post.postCategory)
        }

        dataGroup.newPostData = convertPostArray(posts: homeData.newPostData)
        dataGroup.weeklyTopPostData = convertPostArray(posts: homeData.weeklyTopPostData)
        dataGroup.customizedPostData = convertPostArray(posts: homeData.customizedPostData)
        dataGroup.editorRecommendationPostData = convertPostArray(posts: homeData.editorRecommendationPostData)
        
        return dataGroup
    }
}

extension HomeViewModel {
    enum Input {
        case viewLoaded
        case viewReload
        case postTapped(String)
    }
    enum Output {
        case getHomePostData
        case goToPost(String)
    }
}

struct HomePostViewDataGroup {
    var sectionIndex: [HomeSection]?
    var todayPickPostData: HomePostViewData?
    var newPostData: [HomePostViewData]?
    var weeklyTopPostData: [HomePostViewData]?
    var customizedPostData: [HomePostViewData]?
    var editorRecommendationPostData: [HomePostViewData]?
}

struct HomePostViewData: Hashable, @unchecked Sendable {
    let post_id: String
    let postTitle: String
    let postThumbnailImage: String
    let postCategory: KnowledgeCategory?
}

extension HomePostViewData {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(post_id)
    }
    
    public static func ==(lhs: HomePostViewData, rhs: HomePostViewData) -> Bool {
        return lhs.post_id == rhs.post_id
    }
}
