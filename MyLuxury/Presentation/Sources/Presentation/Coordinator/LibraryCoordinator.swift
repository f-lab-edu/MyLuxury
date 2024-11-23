//
//  LibraryCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Domain

public protocol LibraryCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
    var delegate: LibraryCoordinatorDelegate? { get set }
}

@MainActor
public protocol LibraryCoordinatorDelegate: AnyObject {
    func logout()
}

public protocol LibraryCoordinatorDependency {
    var memberUseCase: MemberUseCase { get }
}

public class LibraryCoordinatorImpl: LibraryCoordinator, @preconcurrency LibraryControllerDelegate {
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    public let dependency: LibraryCoordinatorDependency
    public weak var delegate: LibraryCoordinatorDelegate?
    
    public init(navigationController: UINavigationController, dependency: LibraryCoordinatorDependency) {
        print("LibraryCoordinatorImpl init")
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    deinit {
        print("LibraryCoordinatorImpl deinit")
    }
    
    public func start() {
        let libraryVM = LibraryViewModel(memberUseCase: self.dependency.memberUseCase)
        let libraryVC = LibraryViewController(libraryVM: libraryVM)
        libraryVC.delegate = self
        self.navigationController = UINavigationController(rootViewController: libraryVC)
        self.navigationController.isNavigationBarHidden = true
        libraryVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabBarItem.library.image)?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: TabBarItem.library.image)?.withTintColor(.white, renderingMode: .alwaysOriginal))
    }
    
    @MainActor
    func goToLoginPage() {
        self.delegate?.logout()
    }
}
