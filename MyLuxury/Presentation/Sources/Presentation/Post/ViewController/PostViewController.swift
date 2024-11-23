//
//  PostViewController.swift
//  Presentation
//
//  Created by KoSungmin on 10/29/24.
//

import UIKit
import Combine
import Domain

protocol PostViewControllerDelegate: AnyObject {
    func goToBackScreen()
}

public final class PostViewController: UIViewController {
    private let rootView: PostView
    weak var delegate: PostViewControllerDelegate?
    private let postVM: PostViewModel
    private var cancellable = Set<AnyCancellable>()
    
    
    init(postVM: PostViewModel) {
        print("PostViewController init")
        self.postVM = postVM
        self.rootView = PostView(postVM: self.postVM)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PostViewController deinit")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    public override func loadView() {
        self.view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        postVM.sendInputEvent(input: .viewLoaded)
    }
    
    private func bindData() {
        let output = postVM.transform()
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .goToBackScreen:
                    self.delegate?.goToBackScreen()
                case .getPostOneData:
                    self.rootView.post = self.postVM.post
                }
            }.store(in: &cancellable)
    }
}
