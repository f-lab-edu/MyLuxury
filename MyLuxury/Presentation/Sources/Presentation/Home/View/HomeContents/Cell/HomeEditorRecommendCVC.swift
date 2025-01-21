//
//  HomeEditorRecommendCVC.swift
//  Presentation
//
//  Created by KoSungmin on 10/30/24.
//

import UIKit
import Domain

final class HomeEditorRecommendCVC: UICollectionViewCell {
    struct ViewModel: Hashable {
        let uuid: String
        let homePostTemplate: HomePostTemplate
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
        
        static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
            lhs.uuid == rhs.uuid
        }
    }
    
    static let identifier = "HomeEditorRecommendCVC"
    var viewModel: ViewModel?
    
    /// 게시물의 카테고리
    private let contentCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 36)
        label.textColor = .white
        return label
    }()
    /// 게시물의 제목
    private let contentTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 36)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    /// 게시물의 썸네일
    private let contentThumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
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
        contentThumbnailImageView.addTopBottomShadow(shadowHeight: homeEditorRecommendCVCLength/2)
    }
    
    private func setUpHierarchy() {
        self.addSubview(contentThumbnailImageView)
        self.addSubview(contentTitleLabel)
        self.addSubview(contentCategoryLabel)
    }
    
    private func setUpLayout() {
        contentThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        contentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentThumbnailImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentThumbnailImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentThumbnailImageView.widthAnchor.constraint(equalToConstant: homeEditorRecommendCVCLength),
            contentThumbnailImageView.heightAnchor.constraint(equalToConstant: homeEditorRecommendCVCLength),
            contentTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            contentTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contentTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.contentTitleLabel.text = viewModel.homePostTemplate.postTitle
        self.contentThumbnailImageView.image = UIImage(named: viewModel.homePostTemplate.postThumbnailImage)
        self.contentCategoryLabel.text = viewModel.homePostTemplate.postCategory
    }
}
