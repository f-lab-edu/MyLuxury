//
//  HomeHorizontalCollectionView.swift
//  Presentation
//
//  Created by KoSungmin on 10/28/24.
//

import UIKit
import Combine
import Domain

class HomeHorizontalCollectionView: UIView, HomeContentsSectionView {
    typealias PostData = [Post]
    
    var sectionTitle: String
    var postData: [Post]
    
    private var homeVM: HomeViewModel
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 24)
        label.textColor = .white
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: homeHorizontalCVCLength, height: homeHorizontalCVCLength+30)
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return collectionView
    }()
    
    init(homeVM: HomeViewModel, sectionTitle: String, postData: [Post]) {
        self.sectionTitle = sectionTitle
        self.homeVM = homeVM
        self.postData = postData
        super.init(frame: .zero)
        setUpUI()
        setUpHierarchy()
        setUpCollectionView()
        setUpLayout()
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        sectionTitleLabel.text = sectionTitle
    }
    
    private func setUpHierarchy() {
        addSubview(sectionTitleLabel)
        addSubview(collectionView)
    }

    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeHorizontalCVC.self, forCellWithReuseIdentifier: "HomeHorizontalCVC")
    }
    
    private func setUpLayout() {
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // 레이블 제약 조건
        NSLayoutConstraint.activate([
            sectionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            collectionView.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: homeHorizontalCVCLength+45)
        ])
    }
}

extension HomeHorizontalCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = self.postData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHorizontalCVC", for: indexPath) as! HomeHorizontalCVC
        cell.image = post.postThumbnailImage
        cell.title = post.postTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = postData[indexPath.row]
        homeVM.sendInputEvent(input: .postTapped(post))
    }
}
