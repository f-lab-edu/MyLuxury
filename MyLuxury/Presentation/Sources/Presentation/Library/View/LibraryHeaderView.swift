//
//  LibraryHeaderView.swift
//  Presentation
//
//  Created by KoSungmin on 11/27/24.
//

import UIKit

final class LibraryHeaderView: UIView {
    private let libraryTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.bold, size: 32)
        label.textColor = .white
        label.text = "마이 페이지"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(libraryTextLabel)
    }
    
    private func setUpLayout() {
        libraryTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: screenWidth),
            self.heightAnchor.constraint(equalToConstant: navigationBarHeight),
            libraryTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            libraryTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }
}
