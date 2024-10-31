//
//  HomeEditorRecommendCollectionView.swift
//  Presentation
//
//  Created by KoSungmin on 10/30/24.
//

import UIKit
import Domain

final class HomeEditorRecommendCollectionView: UIView {
    
    /// 해당 뷰의 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 24)
        label.textColor = .white
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: homeEditorRecommendCVCLength, height: homeEditorRecommendCVCLength)
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var posts: [Post] = [] {
        didSet {
            collectionView.reloadData()
            /// post가 바뀔 때마다 높이도 동적으로 변경
            updateCollectionViewHeight()
        }
    }
    
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpCollectionView()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeEditorRecommendCVC.self, forCellWithReuseIdentifier: "HomeEditorRecommendCVC")
    }
    
    private func setUpLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        /// 높이 초기값 설정
        heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: (homeEditorRecommendCVCLength + 30) * CGFloat(posts.count))
        /// 커스텀 제약 조건 활성화
        heightConstraint?.isActive = true
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    /// collectionView의 동적 높이를 설정하기 위한 메소드
    private func updateCollectionViewHeight() {
        heightConstraint?.constant = (homeEditorRecommendCVCLength + 30) * CGFloat(posts.count)
    }
}

extension HomeEditorRecommendCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = self.posts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeEditorRecommendCVC", for: indexPath) as! HomeEditorRecommendCVC
        cell.category = post.postCategory
        cell.title = post.postTitle
        cell.thumbnailImage = post.postThumbnailImage
        return cell
    }
}
