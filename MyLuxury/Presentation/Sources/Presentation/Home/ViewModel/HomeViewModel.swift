//
//  HomeViewModel.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Foundation
import Combine
import Domain

public class HomeViewModel {
    let postUseCase: PostUseCase
    let output: PassthroughSubject<Output, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    
    var todayPickPost: Post? = nil
    var newPosts: [Post] = []
    var weeklyTopPosts: [Post] = []
    var customizedPosts: [Post] = []
    var editorRecommendationPosts: [Post] = []
    
    init(postUseCase: PostUseCase) {
        print("HomeViewModel init")
        self.postUseCase = postUseCase
    }
    
    deinit {
        print("HomeViewModel deinit")
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .viewLoaded:
                self.getHomeViewData()
            case .viewReload:
                self.getHomeViewData()
            case .postTapped(let post):
                self.goToPost(post: post)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func getHomeViewData() {
        postUseCase.getHomeViewData()
            .sink { homeData in
                self.todayPickPost = homeData.todayPickPostData
                self.newPosts = homeData.newPostData
                self.weeklyTopPosts = homeData.weeklyTopPostData
                self.customizedPosts = homeData.customizedPostData
                self.editorRecommendationPosts = homeData.editorRecommendationPostData
                self.output.send(.getHomePostData)
            }.store(in: &cancellables)
    }
    
    func goToPost(post: Post) {
        self.output.send(.goToPost(post))
    }
}

extension HomeViewModel {
    enum Input {
        case viewLoaded
        case viewReload
        case postTapped(Post)
    }
    enum Output {
        case getHomePostData
        case goToPost(Post)
    }
}
