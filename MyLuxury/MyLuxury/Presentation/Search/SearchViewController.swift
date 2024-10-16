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
        self.searchVM = searchVM
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
