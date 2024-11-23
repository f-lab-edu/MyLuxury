//
//  LibraryView.swift
//  Presentation
//
//  Created by KoSungmin on 11/21/24.
//

import UIKit

final class LibraryView: UIView {
    private let libraryVM: LibraryViewModel
    
    private let logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그아웃", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return btn
    }()
    
    init(libraryVM: LibraryViewModel) {
        self.libraryVM = libraryVM
        super.init(frame: .zero)
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(logoutBtn)
    }
    
    private func setUpLayout() {
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoutBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoutBtn.widthAnchor.constraint(equalToConstant: 100),
            logoutBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    private func logout() {
        libraryVM.sendInputEvent(input: .logoutBtnTapped)
    }
}
