//
//  PostViewController.swift
//  Presentation
//
//  Created by KoSungmin on 10/29/24.
//

import UIKit

final class PostViewController: UIViewController {
    let rootView = PostView()
    let postVM: PostViewModel
    
    init(postVM: PostViewModel) {
        print("PostViewController init")
        self.postVM = postVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PostViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = rootView
    }
}
