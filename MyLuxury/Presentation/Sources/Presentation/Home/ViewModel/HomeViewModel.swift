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
    func goToPost(post: Post)
}

class HomeViewModel {
    private let postUseCase: PostUseCase
    private let output: PassthroughSubject<Output, Never> = .init()
    private let input: PassthroughSubject<Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    var homePostData: HomePostData? = nil
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
                self.homePostData = homeData
                self.output.send(.getHomePostData)
            }.store(in: &cancellables)
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
