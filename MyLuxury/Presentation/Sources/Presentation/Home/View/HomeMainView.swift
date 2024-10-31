//
//  HomeMainView.swift
//  Presentation
//
//  Created by KoSungmin on 10/27/24.
//

import UIKit

final class HomeMainView: UIView {
    
    let headerView = HomeHeaderView()
    let contentView = HomeContentsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(headerView)
        self.addSubview(contentView)
    }
    
    private func setUpLayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
