//
//  LibraryViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

class LibraryViewController: UIViewController {
    
    let libraryVM: LibraryViewModel
    
    init(libraryVM: LibraryViewModel) {
        print("LibraryViewController init")
        self.libraryVM = libraryVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LibraryViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
