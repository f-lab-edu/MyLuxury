//
//  HomeHorizontalCVC.swift
//  Presentation
//
//  Created by KoSungmin on 10/29/24.
//

import UIKit

final class HomeHorizontalCVC: UICollectionViewCell {
    static let identifier = "HomeHorizontalCVC"
    
    private var contentImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var contentTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.textColor = UIColor.getCustomColor(.textGray)
        title.font = UIFont.pretendard(.light, size: 14)
        return title
    }()
    
    var image: String? {
        didSet {
            contentImage.image = UIImage(named: image!)
        }
    }
    var title: String? {
        didSet {
            contentTitle.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentImage)
        addSubview(contentTitle)
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        contentTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: self.topAnchor),
            contentImage.widthAnchor.constraint(equalToConstant: homeHorizontalCVCLength),
            contentImage.heightAnchor.constraint(equalToConstant: homeHorizontalCVCLength),
            contentTitle.topAnchor.constraint(equalTo: contentImage.bottomAnchor, constant: 5),
            contentTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
