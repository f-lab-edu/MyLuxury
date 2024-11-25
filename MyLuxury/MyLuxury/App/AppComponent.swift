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

typealias CoordinatorDependency = AppCoordinatorDependency & LoginCoordinatorDependency & TabBarCoordinatorDependency & HomeCoordinatorDependency & SearchCoordinatorDependency & LibraryCoordinatorDependency & PostCoordinatorDependency

public class AppComponent: CoordinatorDependency {
    var window: UIWindow
    public let memberRepository: MemberRepository
    public let postRepository: PostRepository
    public let memberUseCase: MemberUseCase
    public let postUseCase: PostUseCase
    public lazy var loginCoordinator: Coordinator = LoginCoordinatorImpl(dependency: self)
    public lazy var tabBarCoordinator: Coordinator = TabBarCoordinatorImpl(dependency: self)
    public lazy var appCoordinator: Coordinator = AppCoordinator(dependency: self, window: window)
    public lazy var homeCoordinator: Coordinator = HomeCoordinatorImpl(dependency: self)
    public lazy var searchCoordinator: Coordinator = SearchCoordinatorImpl(dependency: self)
    public lazy var libraryCoordinator: Coordinator = LibraryCoordinatorImpl(dependency: self)
    public lazy var postCoordinator: Coordinator = PostCoordinatorImpl(dependency: self)
    
    public init(window: UIWindow) {
        print("AppComponent init")
        self.window = window
        self.memberRepository = MemberRepositoryImpl()
        self.postRepository = PostRepositoryImpl()
        self.memberUseCase = MemberUseCaseImpl(memberRepository: memberRepository)
        self.postUseCase = PostUseCaseImpl(postRepository: postRepository)
    }
}
