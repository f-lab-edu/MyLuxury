//
//  SearchGridViewController.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Combine
import Domain

protocol SearchGridViewControllerDelegate: AnyObject {
    func goToSearchResultView(searchVM: SearchViewModel)
    func goToPostView(post: Post)
}

class SearchGridViewController: UIViewController {
    private let rootView: SearchGridView
    private let searchVM: SearchViewModel
    weak var delegate: SearchGridViewControllerDelegate?
    private let input: PassthroughSubject<SearchViewModel.Input, Never>
    private var cancellables = Set<AnyCancellable>()
    
    init(searchVM: SearchViewModel) {
        print("SearchGridViewController init")
        self.searchVM = searchVM
        self.rootView = SearchGridView(searchVM: searchVM)
        self.input = searchVM.input
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
        searchVM.input.send(.searchGridViewLoaded)
    }
    
    private func bindData() {
        let output = searchVM.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .goToSearchResultView:
                    self.delegate?.goToSearchResultView(searchVM: self.searchVM)
                case .getSearchGridPosts:
                    self.rootView.posts = self.searchVM.searchGridPosts
                case .goToPostView(let post):
                    self.delegate?.goToPostView(post: post)
                default:
                    break
                }
            }.store(in: &cancellables)
    }
}
