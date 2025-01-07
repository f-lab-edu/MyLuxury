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
                dataGroup.sectionOrder = homeData.sectionOrder?.map {
                    $0.toHomeSectionTemplate()
                }
                func convertPostArray(posts: [Post]?) -> [HomePostViewTemplate]? {
                    posts?.map { post in
                        HomePostViewTemplate(
                            postId: post.post_id,
                            postTitle: post.postTitle,
                            postThumbnailImage: post.postThumbnailImage,
                            postCategory: post.postCategory)
                    }
                }
                dataGroup.todayPickPostData = convertPostArray(posts: homeData.todayPickPostData)
                dataGroup.newPostData = convertPostArray(posts: homeData.newPostData)
                dataGroup.weeklyTopPostData = convertPostArray(posts: homeData.weeklyTopPostData)
                dataGroup.customizedPostData = convertPostArray(posts: homeData.customizedPostData)
                dataGroup.editorRecommendationPostData = convertPostArray(posts: homeData.editorRecommendationPostData)
                return dataGroup
            }
            .sink { [weak self] dataGroup in
                guard let self = self else { return }
                self.homeCVVM.setHomeData(homePostData: dataGroup)
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
    var sectionOrder: [HomeSectionTemplate]?
    var todayPickPostData: [HomePostViewTemplate]?
    var newPostData: [HomePostViewTemplate]?
    var weeklyTopPostData: [HomePostViewTemplate]?
    var customizedPostData: [HomePostViewTemplate]?
    var editorRecommendationPostData: [HomePostViewTemplate]?
}

/// Domain의 엔티티와 대응되는 뷰계층용 구조체입니다.
struct HomePostViewTemplate: Hashable, @unchecked Sendable {
    var postId: String
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

enum HomeSectionTemplate: Hashable, @unchecked Sendable {
    case todayPick(HomeTodayPickSectionViewModel)
    case new(HomeNewPostsSectionViewModel)
    case weeklyTop(HomeWeeklyTopSectionViewModel)
    case customized(HomeCustomizedSectionViewModel)
    case editorRecommendation(HomeEditorRecommendSectionViewModel)
    
    // enum은 연관값을 사용할 경우 자동으로 hashable이 만족되지 않으므로 수동으로 hashable을 만족하도록 구현해줘야 함
    func hash(into hasher: inout Hasher) {
        switch self {
        case .todayPick:
            hasher.combine(0) 
        case .new:
            hasher.combine(1)
        case .weeklyTop:
            hasher.combine(2)
        case .customized:
            hasher.combine(3)
        case .editorRecommendation:
            hasher.combine(4)
        }
    }
    
    static func == (lhs: HomeSectionTemplate, rhs: HomeSectionTemplate) -> Bool {
        switch (lhs, rhs) {
        case (.todayPick, .todayPick),
             (.new, .new),
             (.weeklyTop, .weeklyTop),
             (.customized, .customized),
             (.editorRecommendation, .editorRecommendation):
            return true
        default:
            return false
        }
    }
}

/// 도메인 레이어에 선언되어 있는 HomeSection을 HomeSectionTemplate으로 변환하기 위한 익스텐션
extension HomeSection {
    func toHomeSectionTemplate() -> HomeSectionTemplate {
        switch self {
        case .todayPick:
            return .todayPick(HomeTodayPickSectionViewModel())
        case .new:
            return .new(HomeNewPostsSectionViewModel())
        case .weeklyTop:
            return .weeklyTop(HomeWeeklyTopSectionViewModel())
        case .customized:
            return .customized(HomeCustomizedSectionViewModel())
        case .editorRecommendation:
            return .editorRecommendation(HomeEditorRecommendSectionViewModel())
        }
    }
}
