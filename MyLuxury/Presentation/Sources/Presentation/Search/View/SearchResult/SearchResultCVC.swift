//
//  SearchResultCVC.swift
//  Presentation
//
//  Created by KoSungmin on 11/26/24.
//

import UIKit
import Domain

final class SearchResultCVC: UICollectionViewCell {
    static let identifier = "SearchResultCVC"
    
    private let postThumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.regular, size: 16)
        label.textColor = .white
        return label
    }()
    
    private let postCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.light, size: 14)
        label.textColor = UIColor.getCustomColor(.textGray)
        return label
    }()
    
    private var recentPostDeleteBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "postDeleteBtn"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn.addTarget(self, action: #selector(deleteRecentPost), for: .touchUpInside)
        return btn
    }()
    
    var thumbnailImage: String? {
        didSet {
            postThumbnailImageView.image = UIImage(named: thumbnailImage ?? "blackScreen")
        }
    }
    
    var postTitle: String? {
        didSet {
            postTitleLabel.text = postTitle
        }
    }
    
    var postCategory: String? {
        didSet {
            postCategoryLabel.text = postCategory
        }
    }
    
    /// 최근 검색일 경우에는 삭제 버튼이 보이지 않도록
    var isRecentPost: Bool = true {
        didSet {
            recentPostDeleteBtn.isHidden = !isRecentPost
        }
    }

    /// 최근 검색 게시물 개별 삭제 버튼이 눌렸을 때 호출되는 클로저
    var onDeleteRecentSearchPost: (() -> Void)?
    
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
        self.addSubview(postTitleLabel)
        self.addSubview(postCategoryLabel)
        self.addSubview(recentPostDeleteBtn)
    }
    
    private func setUpLayout() {
        self.postThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        self.postTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.postCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.recentPostDeleteBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postThumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            postThumbnailImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            postThumbnailImageView.widthAnchor.constraint(equalToConstant: searchPostResultCVCThumnbnailImageViewLength),
            postThumbnailImageView.heightAnchor.constraint(equalToConstant: searchPostResultCVCThumnbnailImageViewLength),
            postTitleLabel.leadingAnchor.constraint(equalTo: postThumbnailImageView.trailingAnchor, constant: 10),
            postTitleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -2.5),
            postCategoryLabel.leadingAnchor.constraint(equalTo: postThumbnailImageView.trailingAnchor, constant: 10),
            postCategoryLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
            recentPostDeleteBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            recentPostDeleteBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    @objc
    private func deleteRecentPost() {
        self.onDeleteRecentSearchPost?()
    }
}
