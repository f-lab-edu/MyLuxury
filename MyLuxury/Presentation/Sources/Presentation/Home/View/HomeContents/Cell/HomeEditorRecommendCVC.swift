//
//  HomeEditorRecommendCVC.swift
//  Presentation
//
//  Created by KoSungmin on 10/30/24.
//

import UIKit
import Domain

final class HomeEditorRecommendCVC: UICollectionViewCell {
    static let identifier = "HomeEditorRecommendCVC"
    
    /// 게시물의 카테고리
    private let contentCategory: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 36)
        label.textColor = .white
        return label
    }()
    /// 게시물의 제목
    private let contentTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 36)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    /// 게시물의 썸네일
    private let contentThumbnail: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
//    var category: KnowledgeCategory? {
//        didSet {
//            contentCategory.text = category?.name
//        }
//    }
//    var title: String? {
//        didSet {
//            contentTitle.text = title
//        }
//    }
//    var thumbnailImage: String? {
//        didSet {
//            contentThumbnail.image = UIImage(named: thumbnailImage!)
//        }
//    }
    
    var homePostViewData: HomePostViewData? {
        didSet {
            self.contentThumbnail.image = UIImage(named: homePostViewData?.postThumbnailImage ?? "blackScreen")
            self.contentTitle.text = homePostViewData?.postTitle
            self.contentCategory.text = homePostViewData?.postCategory?.name
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
        /// 그림자 레이어 추가
        contentThumbnail.addTopBottomShadow(shadowHeight: homeEditorRecommendCVCLength/2)
    }
    
    private func setUpHierarchy() {
        self.addSubview(contentThumbnail)
        self.addSubview(contentTitle)
        self.addSubview(contentCategory)
    }
    
    private func setUpLayout() {
        contentThumbnail.translatesAutoresizingMaskIntoConstraints = false
        contentTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentThumbnail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentThumbnail.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentThumbnail.widthAnchor.constraint(equalToConstant: homeEditorRecommendCVCLength),
            contentThumbnail.heightAnchor.constraint(equalToConstant: homeEditorRecommendCVCLength),
            contentTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            contentTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contentTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15)
        ])
    }
}
