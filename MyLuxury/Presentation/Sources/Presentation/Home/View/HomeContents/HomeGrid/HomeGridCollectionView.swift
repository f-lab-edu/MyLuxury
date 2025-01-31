//
//  HomeGridCollectionView.swift
//  Presentation
//
//  Created by KoSungmin on 10/30/24.
//

import UIKit
import Domain

// MARK: 현재 아직 레이아웃에 넣지 않은 컬렉션뷰입니다.
// 추후 디자인에 따라 삽입 혹은 삭제될 수 있습니다.

final class HomeGridCollectionView: UIView, HomeContentsSectionView {
    typealias PostData = [Post]
    var sectionTitle: String
    var postData: [Post]
    
    private var homeVM: HomeViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 24)
        label.textColor = .white
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: homeGridCVCWidth, height: homeGridCVCHeight)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
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
        titleLabel.text = sectionTitle
    }
    
    private func setUpHierarchy() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeGridCVC.self, forCellWithReuseIdentifier: "HomeGridCVC")
    }
    
    private func setUpLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: homeGridCVCHeight*2 + 25)
        ])
    }
}

extension HomeGridCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// 항상 4개로 고정
        return postData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = self.postData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeGridCVC", for: indexPath) as! HomeGridCVC
        cell.image = post.postThumbnailImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = postData[indexPath.row]
        homeVM.sendInputEvent(input: .postTapped(post))
    }
}
