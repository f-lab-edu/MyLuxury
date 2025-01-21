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
    public lazy var appCoordinator: AppCoordinator = AppCoordinatorImpl(dependency: self, window: window)
    
    public var loginCoordinator: LoginCoordinator {
        get {
            return LoginCoordinatorImpl(dependency: self)
        }
    }
    
    public var tabBarCoordinator: TabBarCoordinator {
        get {
            return TabBarCoordinatorImpl(dependency: self)
        }
    }
    
    public var homeCoordinator: HomeCoordinator {
        get {
            return HomeCoordinatorImpl(dependency: self)
        }
    }
    
    public var searchCoordinator: SearchCoordinator {
        get {
            return SearchCoordinatorImpl(dependency: self)
        }
    }
    
    public var libraryCoordinator: LibraryCoordinator {
        get {
            return LibraryCoordinatorImpl(dependency: self)
        }
    }
    
    public var postCoordinator: PostCoordinator {
        get {
            return PostCoordinatorImpl(dependency: self)
        }
    }
    
    public init(window: UIWindow) {
        print("AppComponent init")
        self.window = window
        self.memberRepository = MemberRepositoryImpl()
        self.postRepository = PostRepositoryMockImpl()
        self.memberUseCase = MemberUseCaseImpl(memberRepository: memberRepository)
        self.postUseCase = PostUseCaseImpl(postRepository: postRepository)
    }
}
