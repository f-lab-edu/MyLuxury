//
//  TabBarCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

@MainActor
protocol TabBarCoordinator: Coordinator {
    var delegate: TabBarCoordinatorDelegate? { get set }
}

@MainActor
protocol TabBarCoordinatorDelegate: AnyObject {
    func didLogout()
}

@MainActor
public protocol TabBarCoordinatorDependency {
    var homeCoordinator: Coordinator { get }
    var searchCoordinator: Coordinator { get }
    var libraryCoordinator: Coordinator { get }
}

public class TabBarCoordinatorImpl: TabBarCoordinator, @preconcurrency LibraryCoordinatorDelegate {
    weak var delegate: TabBarCoordinatorDelegate?
    private var dependency: TabBarCoordinatorDependency
    
    public init(dependency: TabBarCoordinatorDependency) {
        print("TabBarCoordinatorImpl init")
        self.dependency = dependency
    }
    
    public func start() -> UIViewController {
        var tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .white
        let homeCoordinator = self.dependency.homeCoordinator as! HomeCoordinator
        let searchCoordinator = self.dependency.searchCoordinator as! SearchCoordinator
        let libraryCoordinator = self.dependency.libraryCoordinator as! LibraryCoordinator
        libraryCoordinator.delegate = self
        tabBarController.viewControllers = [
            homeCoordinator.start(),
            searchCoordinator.start(),
            libraryCoordinator.start()
        ]
        return tabBarController
    }
 
    @MainActor
    public func logout() {
        NotificationCenter.default.post(name: .didLogout, object: nil)
        self.delegate?.didLogout()
    }
}
