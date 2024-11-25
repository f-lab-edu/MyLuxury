//
//  LibraryViewController.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit
import Combine

protocol LibraryControllerDelegate: AnyObject {
    func goToLoginPage()
}

class LibraryViewController: UIViewController {
    private let libraryVM: LibraryViewModel
    weak var delegate: LibraryControllerDelegate?
    private let rootView: LibraryView
    private var cancellables = Set<AnyCancellable>()
    
    init(libraryVM: LibraryViewModel) {
        print("LibraryViewController init")
        self.libraryVM = libraryVM
        self.rootView = LibraryView(libraryVM: libraryVM)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LibraryViewController deinit")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    private func bindData() {
        let output = libraryVM.transform()
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .logoutSuccess:
                    self.delegate?.goToLoginPage()
                case .logoutFailed(let message):
                    self.showLogoutFailedAlert(message: message)
                }
            }.store(in: &cancellables)
    }
    
    private func showLogoutFailedAlert(message: String) {
        let alert = UIAlertController(title: "로그아웃 실패 알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
