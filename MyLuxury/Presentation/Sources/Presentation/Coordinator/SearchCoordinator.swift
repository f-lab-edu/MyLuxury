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
    
}

public protocol SearchCoordinatorDependency {
    var postUseCase: PostUseCase { get }
    var postCoordinator: Coordinator { get }
}

public class SearchCoordinatorImpl: SearchCoordinator, @preconcurrency SearchGridViewControllerDelegate, @preconcurrency SearchResultViewControllerDelegate,
                                    @preconcurrency PostViewControllerDelegate {
    private let dependency: SearchCoordinatorDependency
    private var navigationController = UINavigationController()
    private var cancellables = Set<AnyCancellable>()
    
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
        let searchGridVC = SearchGridViewController(searchVM: searchVM)
        searchGridVC.delegate = self
        self.navigationController = UINavigationController(rootViewController: searchGridVC)
        self.navigationController.navigationBar.isHidden = true
        searchGridVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabBarItem.search.image)?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: TabBarItem.search.image)?.withTintColor(.white, renderingMode: .alwaysOriginal))
        return navigationController
    }
    
    @MainActor
    func goToSearchResultView(searchVM: SearchViewModel) {
        let searchResultVC = SearchResultViewController(searchVM: searchVM)
        searchResultVC.delegate = self
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
        guard let postCoordinator = dependency.postCoordinator as? PostCoordinator else { return }
        let postVC = postCoordinator.start(post: post)
        postVC.delegate = self
        self.navigationController.pushViewController(postVC, animated: true)
    }
    
    @MainActor
    func goToBackScreen() {
        self.navigationController.popViewController(animated: true)
    }
}
