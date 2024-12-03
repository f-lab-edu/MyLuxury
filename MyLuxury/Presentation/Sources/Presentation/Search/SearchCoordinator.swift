//
//  SearchCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Domain
import Combine

public protocol SearchCoordinator: Coordinator {
    func start() -> UIViewController
}

public protocol SearchCoordinatorDependency {
    var postUseCase: PostUseCase { get }
    var postCoordinator: PostCoordinator { get }
}

public class SearchCoordinatorImpl: SearchCoordinator, @preconcurrency SearchViewModelDelegate, @preconcurrency PostCoordinatorDelegate {
    private let dependency: SearchCoordinatorDependency
    private var navigationController = UINavigationController()
    private var cancellables = Set<AnyCancellable>()
    var childCoordinators: [Coordinator] = []
    
    public init(dependency: SearchCoordinatorDependency) {
        print("SearchCoordinatorImpl init")
        self.dependency = dependency
        bindNotification()
    }
    
    private func bindNotification() {
        NotificationCenter.default.publisher(for: .didLogout)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.navigationController.viewControllers = []
            }.store(in: &cancellables)
    }
    
    public func start() -> UIViewController {
        let searchVM = SearchViewModel(postUseCase: self.dependency.postUseCase)
        searchVM.delegate = self
        let searchGridVC = SearchGridViewController(searchVM: searchVM)
        self.navigationController = UINavigationController(rootViewController: searchGridVC)
        self.navigationController.navigationBar.isHidden = true
        searchGridVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabBarItem.search.image)?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: TabBarItem.search.image)?.withTintColor(.white, renderingMode: .alwaysOriginal))
        return navigationController
    }
    
    @MainActor
    func goToSearchResultView(searchVM: SearchViewModel) {
        /// searchGridVC와 sesarchResultVC는 같은 뷰모델을 공유
        let searchResultVC = SearchResultViewController(searchVM: searchVM)
        searchResultVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        searchResultVC.modalPresentationStyle = .overCurrentContext
        self.navigationController.present(searchResultVC, animated: true)
    }
    
    @MainActor
    func goBackToResultGridView() {
        self.navigationController.dismiss(animated: true)
    }
    
    @MainActor
    func goToPostView(post: Post) {
        let postCoordinator = self.dependency.postCoordinator
        postCoordinator.delegate = self
        childCoordinators.append(postCoordinator)
        let postVC = postCoordinator.start(post: post)
        self.navigationController.pushViewController(postVC, animated: true)
    }
    
    @MainActor
    public func goToBackScreen() {
        self.childCoordinators = self.childCoordinators.filter { !($0 is PostCoordinator) }
        self.navigationController.popViewController(animated: true)
    }
}
