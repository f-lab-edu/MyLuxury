//
//  PostView.swift
//  Presentation
//
//  Created by KoSungmin on 11/4/24.
//

import UIKit
import Domain

final class PostView: UIView {
    let postVM: PostViewModel
    
    private let header: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let goBackBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "goBackBtn"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 10, height: 18)
        btn.addTarget(self, action: #selector(goToBackScreen), for: .touchUpInside)
        return btn
    }()
    
    private let contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 0
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    var post: Post? {
        didSet {
            contentCollectionView.reloadData()
        }
    }

    init(postVM: PostViewModel) {
        self.postVM = postVM
        super.init(frame: .zero)
        self.backgroundColor = .black
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
    
    private func setUpHierarchy() {
        addSubview(contentCollectionView)
        addSubview(pageControl)
        addSubview(header)
        header.addSubview(goBackBtn)
    }
    
    private func setUpCollectionView() {
        self.contentCollectionView.dataSource = self
        self.contentCollectionView.delegate = self
        self.contentCollectionView.register(PostTitleCVC.self, forCellWithReuseIdentifier: "postTitleCVC")
        self.contentCollectionView.register(PostContentCVC.self, forCellWithReuseIdentifier: "postContentCVC")
    }
    
    private func setUpLayout() {
        header.translatesAutoresizingMaskIntoConstraints = false
        goBackBtn.translatesAutoresizingMaskIntoConstraints = false
        contentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            contentCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            header.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: navigationBarHeight),
            goBackBtn.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            goBackBtn.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -postIndicatorHeight)
        ])
    }
    
    @objc
    private func goToBackScreen() {
        self.postVM.input.send(.goBackBtnTapped)
    }
}

extension PostView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = (post?.postImages?.count ?? 1) + 1
        self.pageControl.numberOfPages = count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        if row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postTitleCVC", for: indexPath) as! PostTitleCVC
            cell.thumbnailImage = post?.postThumbnailImage
            cell.title = post?.postTitle
            cell.editorProfileImage = post?.postEditorProfileImage
            cell.editorName = post?.postEditor
            cell.postCreatedAt = convertDateToString(date: post?.postCreatedAt ?? nil)
            cell.postCategory = "\(post?.postCategory.tagName ?? "")"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postContentCVC", for: indexPath) as! PostContentCVC
            cell.postContentImage = post?.postImages?[row-1]
            cell.postContentImageSource = post?.postImageSources?[row-1]
            cell.postContent = post?.postContents?[row-1]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    /// 스크롤될 때마다 호출되는 메소드
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /// scrollView.contentSize는 스크롤 뷰의 전체 컨텐츠 영역
        /// scrollView.frame은 스크롤뷰 중에서 화면에 보이는 영역의 크기
        /// scrrollView.conTentOffSet은 현재 스크롤의 위치 좌상단 좌표를 의미
        if scrollView.frame.width > 0 {
            let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
            pageControl.currentPage = pageIndex
        }

        let contentOffsetX = scrollView.contentOffset.x
        let maxOffsetX = scrollView.contentSize.width - scrollView.frame.width

        /// 왼쪽 끝에 다다랐을 때 스크롤을 제한
        if contentOffsetX <= 0 {
            scrollView.contentOffset.x = 0
        }

        /// 오른쪽 끝에 다다랐을 때 스크롤을 제한
        if contentOffsetX >= maxOffsetX {
            scrollView.contentOffset.x = maxOffsetX
        }
    }
}
