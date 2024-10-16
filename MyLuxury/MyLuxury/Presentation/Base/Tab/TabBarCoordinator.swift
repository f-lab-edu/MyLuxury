//
//  TabBarCoordinator.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

/// 로그아웃 시 메인 플로우에서 로그인 플로우로 가는 것을 AppCoordinator에 위임하기 위한 델리게이트입니다.
protocol TabBarCoordinatorDelegate {
    
    func didLogout(_ coordinator: TabBarCoordinator)
}

/// 메인 플로우의 코디네이터
class TabBarCoordinator: Coordinator {
    
    var appComponent: AppComponent
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    /// 메인 플로우의 코디네이터네 탭바 컨트롤러를 두고 탭마다 코디네이터를 따로 두도록 설계합니다.
    var tabBarController: UITabBarController
    
    var delegate: TabBarCoordinatorDelegate?
    
    init(appComponent: AppComponent, navigationController: UINavigationController) {
        
        self.appComponent = appComponent
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        /// 각 탭에 해당하는 코디네이터를 생성하고 실행합니다.
        let homeCoordinator = HomeCoordinator(appComponent: self.appComponent, navigationController: self.navigationController)
        let searchCoordinator = SearchCoordinator(appComponent: self.appComponent, navigationController: self.navigationController)
        let libraryCoordinator = LibraryCoordinator(appComponent: self.appComponent, navigationController: self.navigationController)
        
        homeCoordinator.start()
        searchCoordinator.start()
        libraryCoordinator.start()
        
        /// 탭바 컨트롤러에 각 탭 코디네이터의 내비게이션 컨트롤러를 추가합니다.
        tabBarController.viewControllers = [
            homeCoordinator.navigationController,
            searchCoordinator.navigationController,
            libraryCoordinator.navigationController
        ]
        
        /// SceneDelegate에서 생성한 navigationController에 해당 탭바 컨트롤러를 할당합니다.
        navigationController.viewControllers = [tabBarController]
    }
    
    /// 로그아웃 시 실행되는 메소드로 추후 로그아웃 ViewController의 위임 메소드로써 실행됩니다.
    func logout() {
        
        self.delegate?.didLogout(self)
    }
}
