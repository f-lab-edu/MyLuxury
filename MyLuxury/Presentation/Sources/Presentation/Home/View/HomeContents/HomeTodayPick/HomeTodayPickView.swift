//
//  HomeTodayPickView.swift
//  Presentation
//
//  Created by KoSungmin on 10/28/24.
//

import UIKit
import Domain
import Combine

final class HomeTodayPickView: UIView, HomeContentsSectionView {
    var sectionTitle: String
    
    var homeVM: HomeViewModel
    
    private let sectionTitleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.pretendard(.extrabold, size: 24)
        title.textColor = .white
        return title
    }()
    
    private let contentThumbnail: UIImageView = {
        let content = UIImageView()
        content.layer.cornerRadius = 10
        content.isUserInteractionEnabled = true
        return content
    }()
    
    private let contentTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 22)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    var post: Post? {
        didSet {
            contentTitle.text = post?.postTitle
            contentThumbnail.image = UIImage(named: post?.postThumbnailImage ?? "")
        }
    }
    
    init(homeVM: HomeViewModel, sectionTitle: String) {
        self.sectionTitle = sectionTitle
        self.homeVM = homeVM
        super.init(frame: .zero)
        setUpHierarchy()
        setUpLayout()
        setUpGesture()
        self.sectionTitleLabel.text = sectionTitle
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentThumbnail.addTopBottomShadow(shadowHeight: 80)
    }
    
    private func setUpHierarchy() {
        self.addSubview(sectionTitleLabel)
        self.addSubview(contentThumbnail)
        self.addSubview(contentTitle)
    }
    
    private func setUpLayout() {
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentThumbnail.translatesAutoresizingMaskIntoConstraints = false
        contentTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contentThumbnail.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 10),
            contentThumbnail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentThumbnail.widthAnchor.constraint(equalToConstant: hometodayPickViewWidth),
            contentThumbnail.heightAnchor.constraint(equalToConstant: hometodayPickViewHeight),
            contentThumbnail.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            contentTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            contentTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
    
    private func setUpGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(postTapped))
        contentThumbnail.addGestureRecognizer(tapGesture)
    }
    
    @objc func postTapped() {
        if let post = post {
            homeVM.input.send(.postTapped(post))
        }
    }
}
