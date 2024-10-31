//
//  HomeCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Domain

public protocol HomeCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}

public protocol HomeCoordinatorDependency {
    var postUseCase: PostUseCase { get }
}

public class HomeCoordinatorImpl: HomeCoordinator {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    public let dependency: HomeCoordinatorDependency
    
    public init(navigationController: UINavigationController, dependency: HomeCoordinatorDependency) {
        print("HomeCoordinatorImpl init")
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    deinit {
        print("HomeCoordinatorImpl deinit")
    }
    
    public func start() {
        let homeVM = HomeViewModel(postUseCase: self.dependency.postUseCase)
        let homeVC = HomeViewController(homeVM: homeVM)
        self.navigationController = UINavigationController(rootViewController: homeVC)
        self.navigationController.isNavigationBarHidden = true
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabBarItem.home.image)?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: TabBarItem.home.image)?.withTintColor(.white, renderingMode: .alwaysOriginal))
    }
}
