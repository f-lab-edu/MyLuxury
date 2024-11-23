//
//  SearchCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Domain

public protocol SearchCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}

public protocol SearchCoordinatorDependency {
    var postUseCase: PostUseCase { get }
}

public class SearchCoordinatorImpl: SearchCoordinator, @preconcurrency SearchGridViewControllerDelegate, @preconcurrency SearchResultViewControllerDelegate, @preconcurrency PostViewControllerDelegate {
    
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    public let dependency: SearchCoordinatorDependency
    
    public init(navigationController: UINavigationController, dependency: SearchCoordinatorDependency) {
        print("SearchCoordinatorImpl init")
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    deinit {
        print("SearchCoordinatorImpl deinit")
    }
    
    public func start() {
        let searchVM = SearchViewModel(postUseCase: self.dependency.postUseCase)
        let searchGridVC = SearchGridViewController(searchVM: searchVM)
        searchGridVC.delegate = self
        self.navigationController = UINavigationController(rootViewController: searchGridVC)
        self.navigationController.isNavigationBarHidden = true
        searchGridVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabBarItem.search.image)?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: TabBarItem.search.image)?.withTintColor(.white, renderingMode: .alwaysOriginal))
    }
    
    @MainActor
    func goToSearchResultView(searchVM: SearchViewModel) {
        let searchResultVC = SearchResultViewController(searchVM: searchVM)
        searchResultVC.delegate = self
        /// 자연스럽게 이동하도록 설정
        searchResultVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        /// 탭바를 유지하기 위해서 .overCurrentContext로 설정
        searchResultVC.modalPresentationStyle = .overCurrentContext
        self.navigationController.present(searchResultVC, animated: true)
    }
    
    @MainActor
    func goBackToResultGridView() {
        self.navigationController.dismiss(animated: true)
    }
    
    @MainActor
    func goToPostView(post: Post) {
        let postVM = PostViewModel(post: post, postUseCase: self.dependency.postUseCase)
        let postVC = PostViewController(postVM: postVM)
        postVC.delegate = self
        self.navigationController.pushViewController(postVC, animated: true)
        self.navigationController.isNavigationBarHidden = true
    }
    
    @MainActor
    func goToBackScreen() {
        self.navigationController.popViewController(animated: true)
    }
}
