//
//  SearchViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    let searchVM: SearchViewModel
    
    init(searchVM: SearchViewModel) {
        print("SearchViewController init")
        self.searchVM = searchVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SearchViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
