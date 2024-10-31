//
//  HomeGridCVC.swift
//  Presentation
//
//  Created by KoSungmin on 10/30/24.
//

import UIKit

final class HomeGridCVC: UICollectionViewCell {
    
    static let identifier = "HomeGridCVC"
    
    var contentImage: UIImageView = {
        let image = UIImageView()
        /// 이미지를 둥글게 하기 위해 true로 해줘야 함.
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    var image: String? {
        didSet {
            contentImage.image = UIImage(named: image!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentImage)
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: self.topAnchor),
            contentImage.widthAnchor.constraint(equalToConstant: homeGridCVCWidth),
            contentImage.heightAnchor.constraint(equalToConstant: homeGridCVCHeight),
            contentImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
