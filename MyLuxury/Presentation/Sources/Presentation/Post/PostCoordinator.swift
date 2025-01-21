//
//  PostCoordinator.swift
//  Presentation
//
//  Created by KoSungmin on 11/23/24.
//

import UIKit
import Domain

public protocol PostCoordinatorDelegate: AnyObject {
    func goToBackScreen()
}

public protocol PostCoordinator: Coordinator {
    func start(postId: String) -> UIViewController
    var delegate: PostCoordinatorDelegate? { get set }
}

public protocol PostCoordinatorDependency {
    var postUseCase: PostUseCase { get }
}

public class PostCoordinatorImpl: PostCoordinator, @preconcurrency PostViewModelDelegate {
    private var dependency: PostCoordinatorDependency
    public weak var delegate: PostCoordinatorDelegate?
    
    public init(dependency: PostCoordinatorDependency) {
        print("PostCoordinatorImpl init")
        self.dependency = dependency
    }
    
    deinit {
        print("PostCoordinatorImpl deinit")
    }

    public func start(postId: String) -> UIViewController {
        let postVM = PostViewModel(postId: postId, postUseCase: self.dependency.postUseCase)
        postVM.delegate = self
        let postVC = PostViewController(postVM: postVM)
        return postVC
    }
    
    func goToBackScreen() {
        self.delegate?.goToBackScreen()
    }
}
