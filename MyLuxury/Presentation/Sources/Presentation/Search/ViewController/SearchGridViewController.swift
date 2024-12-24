//
//  SearchGridViewController.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Combine
import Domain

final class SearchGridViewController: UIViewController {
    private let rootView: SearchGridView
    private let searchVM: SearchViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(searchVM: SearchViewModel) {
        print("SearchGridViewController init")
        self.searchVM = searchVM
        self.rootView = SearchGridView(searchVM: searchVM)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SearchGridViewController deinit")
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
        searchVM.sendInputEvent(input: .searchGridViewLoaded)
    }
    
    private func bindData() {
        let output = searchVM.transform()
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .goToSearchResultView:
                    self.searchVM.delegate?.goToSearchResultView(searchVM: searchVM)
                case .getSearchGridPosts:
                    self.rootView.posts = self.searchVM.searchGridPosts
                case .goToPostViewFromGrid(let postId):
                    self.searchVM.delegate?.goToPostView(postId: postId)
                default:
                    break
                }
            }.store(in: &cancellables)
    }
}
