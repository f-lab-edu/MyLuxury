//
//  HomeViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    let homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel) {
        print("HomeViewController init")
        self.homeVM = homeVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("HomeViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
