//
//  HomeHeaderView.swift
//  Presentation
//
//  Created by KoSungmin on 10/27/24.
//

import UIKit

final class HomeHeaderView: UIView {
    private let appLogoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "appLogo")
        return logo
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
        self.addSubview(appLogoImageView)
    }
    
    private func setUpLayout() {
        appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.widthAnchor.constraint(equalToConstant: screenWidth),
            self.heightAnchor.constraint(equalToConstant:  navigationBarHeight),
            appLogoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            appLogoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }
}
