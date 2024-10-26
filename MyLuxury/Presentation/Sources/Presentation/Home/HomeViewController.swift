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
    let label: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요"
        label.textColor = .white
        label.font = UIFont.pretendard(.thin, size: 80)
        return label
    }()
    
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
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
