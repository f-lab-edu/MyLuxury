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
    // 이 코드가 homeCVVM으로 옮겨질 예정
//    var homePostData: HomePostViewTemplateGroup? = nil
    weak var delegate: HomeViewModelDelegate?
    var homeCVVM: HomeCVViewModel
    
    init(postUseCase: PostUseCase) {
        print("HomeViewModel init")
        self.postUseCase = postUseCase
        self.homeCVVM = HomeCVViewModel()
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
            .map { homeData -> HomePostViewTemplateGroup in
                var dataGroup = HomePostViewTemplateGroup()
                dataGroup.sectionIndex = homeData.sectionIndex
                func convertPostArray(posts: [Post]?) -> [HomePostViewTemplate]? {
                    posts?.map { post in
                        HomePostViewTemplate(
                            postId: post.post_id,
                            postTitle: post.postTitle,
                            postThumbnailImage: post.postThumbnailImage,
                            postCategory: post.postCategory)
                    }
                }
                
                if let post = homeData.todayPickPostData {
                    dataGroup.todayPickPostData = HomePostViewTemplate(
                        postId: post.post_id,
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
            .sink { [weak self] dataGroup in
                guard let self = self else { return }
                self.homeCVVM.homePostData = dataGroup
                self.homeCVVM.setHomeData(sectionIndex: dataGroup.sectionIndex ?? [])
                self.output.send(.getHomePostData)
            }
            .store(in: &cancellables)
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

struct HomePostViewTemplateGroup {
    var sectionIndex: [HomeSection]?
    var todayPickPostData: HomePostViewTemplate?
    var newPostData: [HomePostViewTemplate]?
    var weeklyTopPostData: [HomePostViewTemplate]?
    var customizedPostData: [HomePostViewTemplate]?
    var editorRecommendationPostData: [HomePostViewTemplate]?
}

/// Domain의 엔티티와 대응되는 뷰계층용 구조체입니다.
struct HomePostViewTemplate: Hashable, @unchecked Sendable {
    let postId: String
    let postTitle: String
    let postThumbnailImage: String
    let postCategory: KnowledgeCategory?
}

extension HomePostViewTemplate {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(postId)
    }
    
    public static func ==(lhs: HomePostViewTemplate, rhs: HomePostViewTemplate) -> Bool {
        return lhs.postId == rhs.postId
    }
}
