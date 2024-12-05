//
//  LibraryView.swift
//  Presentation
//
//  Created by KoSungmin on 11/21/24.
//

import UIKit

final class LibraryView: UIView {
    private let libraryVM: LibraryViewModel
    let headerView = LibraryHeaderView()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth, height: libraryCVCHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private let logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그아웃", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return btn
    }()
    
    init(libraryVM: LibraryViewModel) {
        self.libraryVM = libraryVM
        super.init(frame: .zero)
        self.backgroundColor = .black
        setUpCollectionView()
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LibraryCVC.self, forCellWithReuseIdentifier: "LibraryCVC")
    }
    
    private func setUpHierarchy() {
        self.addSubview(headerView)
        self.addSubview(collectionView)
    }
    
    private func setUpLayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc
    private func logout() {
        libraryVM.sendInputEvent(input: .logoutBtnTapped)
    }
}

extension LibraryView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LibraryItems.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = LibraryItems.allCases[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCVC", for: indexPath) as! LibraryCVC
        cell.itemTitle = item.rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 5:     // 로그아웃
            logout()
        default:
            break
        }
    }
}
