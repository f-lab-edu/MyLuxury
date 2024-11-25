//
//  HomeCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Domain
import Combine

public protocol HomeCoordinator: Coordinator {
    
}

public protocol HomeCoordinatorDependency {
    ///  홈 화면 구성에서 홈 게시물 데이터 전체 조회 API가 필요하기 때문에 postUseCase를 알고 있어야 하는 구조입니다.
    var postUseCase: PostUseCase { get }
    var postCoordinator: Coordinator { get }
}

public class HomeCoordinatorImpl: HomeCoordinator, @preconcurrency HomeControllerDelegate, @preconcurrency PostViewControllerDelegate {
    private let dependency: HomeCoordinatorDependency
    private var navigationController = UINavigationController()
    private var cancellables = Set<AnyCancellable>()
    public init(dependency: HomeCoordinatorDependency) {
        print("HomeCoordidnatorImpl init")
        self.dependency = dependency
        bindNotification()
    }
    
    private func bindNotification() {
        NotificationCenter.default.publisher(for: .didLogout)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.navigationController.viewControllers = []
            }
            .store(in: &cancellables)
    }
    
    public func start() -> UIViewController {
        let homeVM = HomeViewModel(postUseCase: self.dependency.postUseCase)
        let homeVC = HomeViewController(homeVM: homeVM)
        homeVC.delegate = self
        self.navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.navigationBar.isHidden = true
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabBarItem.home.image)?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: TabBarItem.home.image)?.withTintColor(.white, renderingMode: .alwaysOriginal))
        return navigationController
    }
    
    @MainActor
    func goToPost(post: Post) {
        guard var postCoordinator = dependency.postCoordinator as? PostCoordinator else { return }
        let postVC = postCoordinator.start(post: post)
        postVC.delegate = self
        self.navigationController.pushViewController(postVC, animated: true)
    }
    
    @MainActor
    func goToBackScreen() {
        self.navigationController.popViewController(animated: true)
    }
}
