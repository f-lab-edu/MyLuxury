//
//  SearchGridView.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Combine
import Domain

final class SearchGridView: UIView {
    private let searchVM: SearchViewModel
    
    private let searchBarView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.getCustomColor(.darkGray)
        return view
    }()
    
    private let searchBarTextLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 지식을 찾으세요?"
        label.font = UIFont.pretendard(.light, size: 18)
        label.textColor = UIColor.getCustomColor(.lightGray)
        return label
    }()
    
    private let postGridCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var posts: [Post] = [] {
        didSet {
            self.postGridCollectionView.reloadData()
        }
    }
    
    init(searchVM: SearchViewModel) {
        self.searchVM = searchVM
        super.init(frame: .zero)
        self.backgroundColor = .black
        setUpHierarchy()
        setUpLayout()
        setUpCollectionView()
        setUpSearchBarTapGesture()
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCollectionView() {
        postGridCollectionView.dataSource = self
        postGridCollectionView.delegate = self
        postGridCollectionView.register(SearchGridCVC.self, forCellWithReuseIdentifier: "SearchGridCVC")
    }
    
    private func setUpHierarchy() {
        self.addSubview(searchBarView)
        searchBarView.addSubview(searchBarTextLabel)
        self.addSubview(postGridCollectionView)
    }
    
    private func setUpLayout() {
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarTextLabel.translatesAutoresizingMaskIntoConstraints = false
        postGridCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            searchBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchBarView.widthAnchor.constraint(equalToConstant: screenWidth - 30),
            searchBarView.heightAnchor.constraint(equalToConstant: 45),
            searchBarTextLabel.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            searchBarTextLabel.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 15),
            postGridCollectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 20),
            postGridCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            postGridCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postGridCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postGridCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpSearchBarTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchBarTapped))
        searchBarView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func searchBarTapped() {
        searchVM.sendInputEvent(input: .searchBarTapped)
    }
}

extension SearchGridView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = self.posts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchGridCVC", for: indexPath) as! SearchGridCVC
        cell.postImage = post.postThumbnailImage
        cell.postTitle = post.postTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        searchVM.sendInputEvent(input: .postTappedFromGrid(post))
    }
    
    /// 각 셀의 크기를 동적으로 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalSpacing = 3
        let width = (Int(collectionView.bounds.width) - totalSpacing) / 3
        return CGSize(width: width, height: width)
    }
}
