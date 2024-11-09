//
//  HomeViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine
import Domain

protocol HomeControllerDelegate: AnyObject {
    func goToPost(post: Post)
}

class HomeViewController: UIViewController {
    private let rootView: HomeMainView
    weak var delegate: HomeControllerDelegate?
    private let homeVM: HomeViewModel
    private let input: PassthroughSubject<HomeViewModel.Input, Never>
    private var cancellabes = Set<AnyCancellable>()
    
    init(homeVM: HomeViewModel) {
        print("HomeViewController init")
        self.homeVM = homeVM
        self.rootView = HomeMainView(homeVM: homeVM)
        self.input = homeVM.input
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
    }
    
    /// 세 번째로 호출
    /// override func viewWillAppear
    
    /// 네 번째로 호출
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.send(.viewLoaded)
    }
    
    private func bindData() {
        let output = homeVM.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .getHomePostData:
                    self.rootView.contentView.homeTodayPickView.post = self.homeVM.todayPickPost
                    self.rootView.contentView.newPostsCV.posts = self.homeVM.newPosts
                    self.rootView.contentView.weeklyTopPostsCV.posts = self.homeVM.weeklyTopPosts
                    self.rootView.contentView.preferPostCV.posts = self.homeVM.customizedPosts
                    self.rootView.contentView.homeEditorRecommendCV.posts = self.homeVM.editorRecommendationPosts
                case .goToPost(let post):
                    self.delegate?.goToPost(post: post)
                }
            }.store(in: &cancellabes)
    }
}
