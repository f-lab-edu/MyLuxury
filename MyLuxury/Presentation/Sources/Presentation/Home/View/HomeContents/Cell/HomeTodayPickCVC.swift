//
//  HomeTodayPickCVC.swift
//  Presentation
//
//  Created by KoSungmin on 12/11/24.
//

import UIKit

final class HomeTodayPickCVC: UICollectionViewCell {
    static let identifier = "HomeTodayPickCVC"
    
    private let postThumbnailImageView: UIImageView = {
        let content = UIImageView()
        content.layer.cornerRadius = 10
        content.isUserInteractionEnabled = true
        return content
    }()
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 22)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    var postThumbnailImage: String? {
        didSet {
            self.postThumbnailImageView.image = UIImage(named: postThumbnailImage ?? "blackScreen")
        }
    }
    
    var postTitle: String? {
        didSet {
            self.postTitleLabel.text = postTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(postThumbnailImageView)
        postThumbnailImageView.addSubview(postTitleLabel)
    }
    
    private func setUpLayout() {
        postThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        postTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postThumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor),
            postThumbnailImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            postThumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postThumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            postTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            postTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
}
