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
    private var homePostTemplateGroup: [HomePostTemplateGroup] = []
    
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
                self.getHomePostData()
            case .viewReload:
                self.getHomePostData()
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

    func getHomePostData() {
        postUseCase.getHomeViewData()
            .map { homePostData -> [HomePostTemplateGroup] in
                var homePostTemplateGroup: [HomePostTemplateGroup] = []
                if let sectionOrder = homePostData.sectionOrder {
                    for section in sectionOrder {
                        switch section {
                        case .todayPick:
                            if let todayPickPostData = homePostData.todayPickPostData {
                                homePostTemplateGroup.append(HomePostTemplateGroup(
                                    type: .todayPick,
                                    homePosts: todayPickPostData.map { $0.toHomePostTemplate() }))
                            }
                        case .new:
                            if let newPostData = homePostData.newPostData {
                                homePostTemplateGroup.append(HomePostTemplateGroup(
                                    type: .newPost,
                                    homePosts: newPostData.map { $0.toHomePostTemplate() }))
                            }
                        case .weeklyTop:
                            if let weeklyTopPostData = homePostData.weeklyTopPostData {
                                homePostTemplateGroup.append(HomePostTemplateGroup(
                                    type: .weeklyTop,
                                    homePosts: weeklyTopPostData.map { $0.toHomePostTemplate() }))
                            }
                        case .customized:
                            if let customizedPostData = homePostData.customizedPostData {
                                homePostTemplateGroup.append(HomePostTemplateGroup(
                                    type: .customized,
                                    homePosts: customizedPostData.map { $0.toHomePostTemplate() }))
                            }
                        case .editorRecommendation:
                            if let editorRecommendationPostData = homePostData.editorRecommendationPostData {
                                homePostTemplateGroup.append(HomePostTemplateGroup(
                                    type: .editorRecommend,
                                    homePosts: editorRecommendationPostData.map { $0.toHomePostTemplate() }))
                            }
                        }
                    }
                }
                return homePostTemplateGroup
            }
            .sink { [weak self] homePostTemplateGroup in
                guard let self = self else { return }
                self.homePostTemplateGroup = homePostTemplateGroup
                self.output.send(.getHomePostData(vm: makeViewModel()))
            }
            .store(in: &cancellables)
    }
    
    private func makeViewModel() -> HomeContentsView.ViewModel {
        let sections = homePostTemplateGroup.map { group -> HomeSectionCompositeViewModel in
            switch group.type {
            case .todayPick:
                return .init(headerVM: .todayPick(headerVM: .init(sectionTitle: group.type.title)),
                             cellVMs: group.homePosts.map {
                                .todayPick(cellVM: .init(uuid: $0.uuid.uuidString,
                                    homePostTemplate: .init(
                                        postId: $0.postId,
                                        postTitle: $0.postTitle,
                                        postThumbnailImage: $0.postThumbnailImage,
                                        postCategory: $0.postCategory)))
                })
            case .newPost:
                return .init(headerVM: .newPost(headerVM: .init(sectionTitle: group.type.title)),
                             cellVMs: group.homePosts.map {
                                .newPost(cellVM: .init(uuid: $0.uuid.uuidString,
                                    homePostTemplate: .init(
                                        postId: $0.postId,
                                        postTitle: $0.postTitle,
                                        postThumbnailImage: $0.postThumbnailImage,
                                        postCategory: $0.postCategory)))
                })
            case .weeklyTop:
                return .init(headerVM: .weeklyTop(headerVM: .init(sectionTitle: group.type.title)),
                             cellVMs: group.homePosts.map {
                                .weeklyTop(cellVM: .init(uuid: $0.uuid.uuidString,
                                    homePostTemplate: .init(
                                        postId: $0.postId,
                                        postTitle: $0.postTitle,
                                        postThumbnailImage: $0.postThumbnailImage,
                                        postCategory: $0.postCategory)))
                })
            case .customized:
                return .init(headerVM: .customized(headerVM: .init(sectionTitle: group.type.title)),
                             cellVMs: group.homePosts.map {
                                .customized(cellVM: .init(uuid: $0.uuid.uuidString,
                                    homePostTemplate: .init(
                                        postId: $0.postId,
                                        postTitle: $0.postTitle,
                                        postThumbnailImage: $0.postThumbnailImage,
                                        postCategory: $0.postCategory)))
                })
            case .editorRecommend:
                return .init(headerVM: .editorRecommend(headerVM: .init(sectionTitle: group.type.title)),
                             cellVMs: group.homePosts.map {
                                .editorRecommend(cellVM: .init(uuid: $0.uuid.uuidString,
                                    homePostTemplate: .init(
                                        postId: $0.postId,
                                        postTitle: $0.postTitle,
                                        postThumbnailImage: $0.postThumbnailImage,
                                        postCategory: $0.postCategory)))
                })
            }
        }
        return .init(sections: sections)
    }
}

extension HomeViewModel {
    enum Input {
        case viewLoaded
        case viewReload
        case postTapped(String)
    }
    enum Output {
        case getHomePostData(vm: HomeContentsView.ViewModel)
        case goToPost(String)
    }
}

struct HomePostTemplate: Sendable {
    let uuid = UUID()
    let postId: String
    let postTitle: String
    let postThumbnailImage: String
    let postCategory: String
}

struct HomePostTemplateGroup {
    enum GroupType {
        case todayPick
        case newPost
        case weeklyTop
        case customized
        case editorRecommend
        
        var title: String {
            switch self {
            case .todayPick:
                return "오늘의 PICK"
            case .newPost:
                return "새로 게시된 지식"
            case .weeklyTop:
                return "이번 주 TOP10"
            case .customized:
                return "회원님이 좋아할 만한"
            case .editorRecommend:
                return "에디터 추천 지식"
            }
        }
    }
    let type: GroupType
    let homePosts: [HomePostTemplate]
}

extension Post {
    func toHomePostTemplate() -> HomePostTemplate {
        return HomePostTemplate(
            postId: self.post_id,
            postTitle: self.postTitle,
            postThumbnailImage: self.postThumbnailImage,
            postCategory: self.postCategory.name)
    }
}
