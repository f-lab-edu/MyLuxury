//
//  PostCoordinator.swift
//  Presentation
//
//  Created by KoSungmin on 11/23/24.
//

import UIKit
import Domain

public protocol PostCoordinator: Coordinator {
    
}

public protocol PostCoordinatorDependency {
    var postUseCase: PostUseCase { get }
}

public class PostCoordinatorImpl: PostCoordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    public var dependency: PostCoordinatorDependency
    
    public init(navigationController: UINavigationController, dependency: PostCoordinatorDependency) {
        print("PostCoordinatorImpl init")
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    public func start() {
        
    }
    
    public func start(post: Post) -> PostViewController {
        let postVm = PostViewModel(post: post, postUseCase: self.dependency.postUseCase)
        let postVC = PostViewController(postVM: postVm)
        return postVC
    }
}
