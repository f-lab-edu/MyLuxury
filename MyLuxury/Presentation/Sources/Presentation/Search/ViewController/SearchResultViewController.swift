//
//  SearchResultViewController.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Domain
import Combine

protocol SearchResultViewControllerDelegate: AnyObject {
    func goBackToResultGridView()
}

class SearchResultViewController: UIViewController {
    private let rootView: SearchResultView
    private let searchVM: SearchViewModel
    weak var delegate: SearchResultViewControllerDelegate?
    private let input: PassthroughSubject<SearchViewModel.Input, Never>
    private var cancellables = Set<AnyCancellable>()
    
    init(searchVM: SearchViewModel) {
        print("SearchResultViewController init")
        self.searchVM = searchVM
        self.rootView = SearchResultView(searchVM: searchVM)
        self.input = searchVM.input
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
    }
    
    private func bindData() {
        let output = searchVM.output
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .goBackToSearchResultView:
                    self.delegate?.goBackToResultGridView()
                default:
                    break
                }
            }.store(in: &cancellables)
    }
}
