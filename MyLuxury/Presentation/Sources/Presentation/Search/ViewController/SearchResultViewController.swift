//
//  SearchResultViewController.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Domain
import Combine

class SearchResultViewController: UIViewController {
    private let rootView: SearchResultView
    private let searchVM: SearchViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(searchVM: SearchViewModel) {
        print("SearchResultViewController init")
        self.searchVM = searchVM
        self.rootView = SearchResultView(searchVM: searchVM)
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("SearchResultViewController deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchVM.sendInputEvent(input: .searchResultViewLoaded)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchVM.sendInputEvent(input: .searchResultViewDisappeared)
    }
    
    private func bindData() {
        /// 두 개의 VC가 하나의 VM을 동시에 사용하고 있으므로
        /// 이중으로 구독 등록을 하지 않기 위해서 이곳에서는 searchVM.transform()을 실행하지 않습니다.
        let output = searchVM.getOutputInstance()
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .goBackToSearchResultView:
                    self.searchVM.delegate?.goBackToResultGridView()
                case .getRecentSearchPosts:
                    self.rootView.recentSearchPosts = self.searchVM.recentSearchPosts
                case .goToPostViewFromSearch(let post):
                    self.searchVM.delegate?.goToPostView(post: post)
                case .removeRecentSearchPost(let index):
                    self.rootView.recentSearchPosts.remove(at: index)
                default:
                    break
                }
            }.store(in: &cancellables)
    }
}
