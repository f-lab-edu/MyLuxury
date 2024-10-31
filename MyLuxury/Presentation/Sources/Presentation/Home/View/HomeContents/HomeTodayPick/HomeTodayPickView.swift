//
//  HomeTodayPickView.swift
//  Presentation
//
//  Created by KoSungmin on 10/28/24.
//

import UIKit
import Domain

final class HomeTodayPickView: UIView {
    
    let viewTitle: UILabel = {
        let title = UILabel()
        title.text = "오늘의 PICK"
        title.font = UIFont.pretendard(.extrabold, size: 24)
        title.textColor = .white
        return title
    }()
    
    let contentThumbnail: UIImageView = {
        let content = UIImageView()
        content.layer.cornerRadius = 10
        return content
    }()
    
    let contentTitle: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentThumbnail.addTopBottomShadow(shadowHeight: 80)
    }
    
    func setUpHierarchy() {
        self.addSubview(viewTitle)
        self.addSubview(contentThumbnail)
        self.addSubview(contentTitle)
    }
    
    func setUpLayout() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        contentThumbnail.translatesAutoresizingMaskIntoConstraints = false
        contentTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: self.topAnchor),
            viewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contentThumbnail.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 10),
            contentThumbnail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentThumbnail.widthAnchor.constraint(equalToConstant: screenWidth-30),
            contentThumbnail.heightAnchor.constraint(equalToConstant: (screenWidth-30)/2.5),
            contentThumbnail.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            contentTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            contentTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}
