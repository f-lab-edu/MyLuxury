//
//  PostCoordinator.swift
//  Presentation
//
//  Created by KoSungmin on 11/23/24.
//

import UIKit
import Domain

public protocol PostCoordinator: Coordinator {
    func start(post: Post) -> PostViewController
}

public protocol PostCoordinatorDependency {
    var postUseCase: PostUseCase { get }
}

public class PostCoordinatorImpl: PostCoordinator {
    private var dependency: PostCoordinatorDependency
    
    public init(dependency: PostCoordinatorDependency) {
        print("PostCoordinatorImpl init")
        self.dependency = dependency
    }
    
    public func start() -> UIViewController {
        fatalError("PostCoordinator에서 start()를 start(post:)로 대신하여 사용합니다.")
    }
    
    public func start(post: Post) -> PostViewController {
        let postVM = PostViewModel(post: post, postUseCase: self.dependency.postUseCase)
        let postVC = PostViewController(postVM: postVM)
        return postVC
    }
}
