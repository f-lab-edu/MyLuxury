//
//  HomeEditorRecommendView.swift
//  Presentation
//
//  Created by KoSungmin on 10/30/24.
//

import UIKit
import Domain

/// Model 구현 전 UI 작업을 위한 임시 튜플 타입 정의
typealias TemporaryPost = (KnowledgeCategory, String, String)

final class HomeEditorRecommendView: UIView {
    var post: [TemporaryPost] = []
    /// 해당 뷰의 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "에디터 추천 지식"
        label.font = UIFont.pretendard(.extrabold, size: 24)
        label.textColor = .white
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContents() {
        
    }
    
    private func setUpLayout() {
        
    }
    
}

final class HomeEditorRecommendCVC: UICollectionViewCell {
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
        label.font = UIFont.pretendard(.extrabold, size: 24)
        label.textColor = .white
        return label
    }()
    /// 게시물의 썸네일
    private let contentThumbnail: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    var category: KnowledgeCategory? {
        didSet {
            contentCategory.text = category?.name
        }
    }
    var title: String? {
        didSet {
            contentTitle.text = title
        }
    }
    var thumbnailImage: String? {
        didSet {
            contentThumbnail.image = UIImage(named: thumbnailImage!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
