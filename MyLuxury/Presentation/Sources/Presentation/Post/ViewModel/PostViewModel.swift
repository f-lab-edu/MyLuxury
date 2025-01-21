//
//  PostViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 11/4/24.
//

import UIKit
import Domain
import Combine

protocol PostViewModelDelegate: AnyObject {
    func goToBackScreen()
}

class PostViewModel {
    let postUseCase: PostUseCase
    private let output: PassthroughSubject<Output, Never> = .init()
    private let input: PassthroughSubject<Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    weak var delegate: PostViewModelDelegate?
    
    let postId: String
    var post: PostTemplate?
    
    init(postId: String, postUseCase: PostUseCase) {
        print("PostViewModel init")
        self.postUseCase = postUseCase
        self.postId = postId
    }
    
    deinit {
        print("PostViewModel deinit")
    }
    
    func transform() -> AnyPublisher<Output, Never> {
        let input = input.eraseToAnyPublisher()
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .goBackBtnTapped:
                self.output.send(.goToBackScreen)
            case .viewLoaded:
                self.getPostOneData(postId: self.postId)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func sendInputEvent(input: Input) {
        switch input {
        case .goBackBtnTapped:
            self.input.send(.goBackBtnTapped)
        case .viewLoaded:
            self.input.send(.viewLoaded)
        }
    }

    func getPostOneData(postId: String) {
        postUseCase.getPostOneData(postId: postId)
            .sink { [weak self] postData in
                guard let self = self else { return }
                self.post = postData.toPostTemplate()
                self.output.send(.getPostOneData(vm: makeViewModel()))
            }
            .store(in: &cancellables)
    }
    
    private func makeViewModel() -> PostView.ViewModel {
        var viewModels: [PostCellViewModel] = []
        
        if let post = self.post {
            let titleViewModel = PostTitleCVC.ViewModel(
                uuid: UUID().uuidString,
                title: post.postTitle,
                editorProfileImage: post.postEditorProfileImage,
                thumbnailImage: post.postThumbnailImage,
                editorName: post.postEditor,
                postCreatedAt: convertDateToString(date: post.postCreatedAt),
                postCategory: post.postCategory)
            viewModels.append(.title(cellVM: titleViewModel))
            
            for i in 0..<(post.postContents?.count ?? 0) {
                let postContentVM: PostContentCVC.ViewModel = .init(
                    uuid: UUID().uuidString,
                    postContentImage: self.post?.postImages?[i],
                    postContentImageSource: self.post?.postImageSources?[i],
                    postContentText: self.post?.postContents?[i])
                viewModels.append(.content(cellVM: postContentVM))
            }
        }
        return .init(viewModels: viewModels)
    }
}

extension PostViewModel {
    enum Input {
        case goBackBtnTapped
        case viewLoaded
    }
    enum Output {
        case goToBackScreen
        case getPostOneData(vm: PostView.ViewModel)
    }
}

struct PostTemplate: Sendable {
    let uuid = UUID()
    let postId: String
    let postCategory: String
    let postTitle: String
    let postThumbnailImage: String
    let postImages: [String]?
    let postImageSources: [String]?
    let postContents: [String]?
    let postEditor: String?
    let postEditorProfileImage: String?
    let postView: Int?
    let postCreatedAt: Date?
    let postUpdatedAt: Date?
}

extension Post {
    func toPostTemplate() -> PostTemplate {
        return PostTemplate(
            postId: self.post_id,
            postCategory: self.postCategory.name,
            postTitle: self.postTitle,
            postThumbnailImage: self.postThumbnailImage,
            postImages: self.postImages,
            postImageSources: self.postImageSources,
            postContents: self.postContents,
            postEditor: self.postEditor,
            postEditorProfileImage: self.postEditorProfileImage,
            postView: self.postView,
            postCreatedAt: self.postCreatedAt,
            postUpdatedAt: self.postUpdatedAt)
    }
}
