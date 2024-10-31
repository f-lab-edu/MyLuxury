//
//  HomeHeaderView.swift
//  Presentation
//
//  Created by KoSungmin on 10/27/24.
//

import UIKit

final class HomeHeaderView: UIView {
    let blurLogoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "blurLogo")
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
    
    func setUpHierarchy() {
        self.addSubview(blurLogoImage)
    }
    
    func setUpLayout() {
        blurLogoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.widthAnchor.constraint(equalToConstant: screenWidth),
            self.heightAnchor.constraint(equalToConstant:  navigationBarHeight),
            blurLogoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            blurLogoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }
}
