//
//  SearchGridCVC.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit

final class SearchGridCVC: UICollectionViewCell {
    static let identifier = "SearchGridCVC"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 20)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
     
    var postImage: String? {
        didSet {
            postImageView.image = UIImage(named: postImage ?? "blackScreen")
        }
    }
    
    var postTitle: String? {
        didSet {
            postTitleLabel.text = postTitle
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
        self.addSubview(postImageView)
//        postImageView.addSubview(postTitleLabel)
    }
    
    private func setUpLayout() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
//        postTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: self.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//            postTitleLabel.topAnchor.constraint(equalTo: postImageView.centerYAnchor),
//            postTitleLabel.leadingAnchor.constraint(equalTo: postImageView.leadingAnchor),
//            postTitleLabel.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor),
//            postTitleLabel.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor)
        ])
    }
}
