//
//  HomeViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine
import Domain

final class HomeViewController: UIViewController {
    private let rootView: HomeMainView
    private let homeVM: HomeViewModel
    private var cancellabes = Set<AnyCancellable>()
    
    init(homeVM: HomeViewModel) {
        print("HomeViewController init")
        self.homeVM = homeVM
        self.rootView = HomeMainView(homeVM: homeVM)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("HomeViewController deinit")
    }
    
    /// 첫 번째로 호출
    override func loadView() {
        self.view = rootView
    }
    
    /// 두 번째로 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        homeVM.sendInputEvent(input: .viewLoaded)
    }
    
    /// 세 번째로 호출
    /// override func viewWillAppear
    
    /// 네 번째로 호출
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
    
    private func bindData() {
        let output = homeVM.transform()
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .getHomePostData:
                    self.rootView.contentView.applyInitialSnapshot()
                case .goToPost(let post):
                    self.homeVM.delegate?.goToPost(postId: post)
                }
            }.store(in: &cancellabes)
    }
}
