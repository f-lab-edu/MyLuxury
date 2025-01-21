//
//  PostContentCVC.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Domain
import Combine

final class PostContentCVC: UICollectionViewCell {
    struct ViewModel: Hashable {
        let uuid: String
        let postContentImage: String?
        let postContentImageSource: String?
        let postContentText: String?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
        
        static func == (lhs: PostContentCVC.ViewModel, rhs: PostContentCVC.ViewModel) -> Bool {
            lhs.uuid == rhs.uuid
        }
    }
    
    static let identifier = "postContentCVC"
    
    private let backImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let backBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.8
        return view
    }()
    
    private let postContentImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private let postContentImageSourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.medium, size: 16)
        label.textColor = .gray
        return label
    }()
    
    private let pageContentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let postContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.medium, size: 18
        )
        label.textColor = .white
        label.numberOfLines = 0
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
        self.addSubview(backImageView)
        backImageView.addSubview(backBlackView)
        self.addSubview(postContentImageView)
        self.addSubview(postContentImageSourceLabel)
        self.addSubview(pageContentScrollView)
        pageContentScrollView.addSubview(postContentLabel)
    }
    
    private func setUpLayout() {
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backBlackView.translatesAutoresizingMaskIntoConstraints = false
        postContentImageView.translatesAutoresizingMaskIntoConstraints = false
        postContentImageSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        pageContentScrollView.translatesAutoresizingMaskIntoConstraints = false
        postContentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backBlackView.topAnchor.constraint(equalTo: self.topAnchor),
            backBlackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backBlackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backBlackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            postContentImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            postContentImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            postContentImageView.widthAnchor.constraint(equalToConstant: screenWidth),
            postContentImageView.heightAnchor.constraint(equalToConstant: screenWidth),
            postContentImageSourceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            postContentImageSourceLabel.bottomAnchor.constraint(equalTo: postContentImageView.topAnchor, constant: -5),
            pageContentScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            pageContentScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            pageContentScrollView.topAnchor.constraint(equalTo: postContentImageView.bottomAnchor, constant: 10),
            pageContentScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -postIndicatorHeight-50),
            postContentLabel.leadingAnchor.constraint(equalTo: pageContentScrollView.leadingAnchor),
            postContentLabel.trailingAnchor.constraint(equalTo: pageContentScrollView.trailingAnchor),
            postContentLabel.topAnchor.constraint(equalTo: pageContentScrollView.topAnchor),
            postContentLabel.bottomAnchor.constraint(equalTo: pageContentScrollView.bottomAnchor),
            postContentLabel.widthAnchor.constraint(equalTo: pageContentScrollView.widthAnchor)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        self.backImageView.image = UIImage(named: viewModel.postContentImage ?? "blackScreen")
        self.postContentImageView.image = UIImage(named: viewModel.postContentImage ?? "blackScreen")
        self.postContentImageSourceLabel.text = viewModel.postContentImageSource
        self.postContentLabel.text = viewModel.postContentText
    }
}
