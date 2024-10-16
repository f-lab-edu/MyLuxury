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
        self.libraryVM = libraryVM
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
