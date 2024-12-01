//
//  LibraryCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Domain
import Combine

public protocol LibraryCoordinator: Coordinator {
    var delegate: LibraryCoordinatorDelegate? { get set }
}

public protocol LibraryCoordinatorDelegate: AnyObject {
    func logout()
}

@MainActor
public protocol LibraryCoordinatorDependency {
    var memberUseCase: MemberUseCase { get }
}

public class LibraryCoordinatorImpl: LibraryCoordinator, @preconcurrency LibraryViewModelDelegate {
    public weak var delegate: LibraryCoordinatorDelegate?
    private let dependency: LibraryCoordinatorDependency
    private var navigationController = UINavigationController()
    private var cancellables = Set<AnyCancellable>()
    
    public init(dependency: LibraryCoordinatorDependency) {
        print("LibraryCoordinatorImpl init")
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
        let libraryVM = LibraryViewModel(memberUseCase: self.dependency.memberUseCase)
        let libraryVC = LibraryViewController(libraryVM: libraryVM)
        libraryVM.delegate = self
        self.navigationController = UINavigationController(rootViewController: libraryVC)
        self.navigationController.navigationBar.isHidden = true
        libraryVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabBarItem.library.image)?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: TabBarItem.library.image)?.withTintColor(.white, renderingMode: .alwaysOriginal))
        return navigationController
    }
    
    @MainActor
    func goToLoginPage() {
        self.delegate?.logout()
    }
}
