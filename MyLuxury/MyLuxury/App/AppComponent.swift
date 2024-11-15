//
//  AppComponent.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Data
import Domain
import Presentation

typealias CoordinatorDependency = AppCoordinatorDependency & LoginCoordinatorDependency & TabBarCoordinatorDependency & HomeCoordinatorDependency

public class AppComponent: CoordinatorDependency {
    var navigationController: UINavigationController
    public let urlSession: URLSession
    public let memberRepository: MemberRepository
    public let postRepository: PostRepository
    public let memberUseCase: MemberUseCase
    public let postUseCase: PostUseCase
    public var searchCoordinator: Coordinator
    public var libraryCoordinator: Coordinator
    public lazy var loginCoordinator: Coordinator = LoginCoordinatorImpl(navigationController: navigationController, dependency: self)
    public lazy var tabBarCoordinator: Coordinator = TabBarCoordinatorImpl(navigationController: navigationController, dependency: self)
    public lazy var appCoordinator: Coordinator = AppCoordinator(navigationController: self.navigationController, dependency: self)
    public lazy var homeCoordinator: Coordinator = HomeCoordinatorImpl(navigationController: self.navigationController, dependency: self)
    
    /// 다른 인스턴스로 실행하고 싶다면 이 생성자에서 해당하는 인스턴스로 바꿔주시면 됩니다.
    public init(navigationController: UINavigationController) {
        print("AppComponent init")
        self.navigationController = navigationController
        self.urlSession = URLSession.shared
        self.memberRepository = MemberRepositoryImpl(urlSession: self.urlSession)
        self.postRepository = PostRepositoryMockImpl()
        self.memberUseCase = MemberUseCaseImpl(memberRepository: self.memberRepository)
        self.postUseCase = PostUseCaseImpl(postRepository: self.postRepository)
        self.searchCoordinator = SearchCoordinatorImpl(navigationController: self.navigationController)
        self.libraryCoordinator = LibraryCoordinatorImpl(navigationController: self.navigationController)
    }
}
