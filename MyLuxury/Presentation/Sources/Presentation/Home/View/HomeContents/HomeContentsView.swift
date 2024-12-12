//
//  HomeContentsView.swift
//  Presentation
//
//  Created by KoSungmin on 10/28/24.
//

import UIKit
import Combine
import Domain

enum HomeSection: String, CaseIterable {
    case todayPick = "오늘의 Pick"
    case new = "새로 게시된 지식"
    case weeklyTop = "이번 주 TOP10"
    case customized = "회원님이 좋아할만한"
    case editorRecommendation = "에디터 추천 지식"
}

final class HomeContentsView: UIView {
    private var homeVM: HomeViewModel
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource = {
        var dataSource = UICollectionViewDiffableDataSource<HomeSection, Post>(collectionView: collectionView) { collectionView, indexPath, post in
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTodayPickCVC.identifier, for: indexPath) as! HomeTodayPickCVC
                cell.postThumbnailImage = post.postThumbnailImage
                cell.postTitle = post.postTitle
                return cell
            case 1, 2, 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHorizontalCVC.identifier, for: indexPath) as! HomeHorizontalCVC
                cell.image = post.postThumbnailImage
                cell.title = post.postTitle
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEditorRecommendCVC.identifier, for: indexPath) as! HomeEditorRecommendCVC
                cell.category = post.postCategory
                cell.thumbnailImage = post.postThumbnailImage
                cell.title = post.postTitle
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: HomeContentsSectionHeaderView.identifier,
                                                                             for: indexPath) as! HomeContentsSectionHeaderView
            switch indexPath.section {
            case 0: headerView.sectionTitle = HomeSection.todayPick.rawValue
            case 1: headerView.sectionTitle = HomeSection.new.rawValue
            case 2: headerView.sectionTitle = HomeSection.weeklyTop.rawValue
            case 3: headerView.sectionTitle = HomeSection.customized.rawValue
            default: headerView.sectionTitle = HomeSection.editorRecommendation.rawValue
            }
            return headerView
        }
        
        return dataSource
    }()
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        super.init(frame: .zero)
        setUpCollectionView()
        setUpHierarchy()
        setUpLayout()
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.register(HomeContentsSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeContentsSectionHeaderView.identifier)
        collectionView.register(HomeTodayPickCVC.self, forCellWithReuseIdentifier: HomeTodayPickCVC.identifier)
        collectionView.register(HomeHorizontalCVC.self, forCellWithReuseIdentifier: HomeHorizontalCVC.identifier)
        collectionView.register(HomeEditorRecommendCVC.self, forCellWithReuseIdentifier: HomeEditorRecommendCVC.identifier)
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, Post>()
        snapshot.appendSections([.todayPick, .new, .weeklyTop, .customized, .editorRecommendation])
        if let todayPickPostData = homeVM.homePostData?.todayPickPostData {
            snapshot.appendItems([todayPickPostData], toSection: .todayPick)
        }
        snapshot.appendItems(homeVM.homePostData?.newPostData ?? [], toSection: .new)
        snapshot.appendItems(homeVM.homePostData?.weeklyTopPostData ?? [], toSection: .weeklyTop)
        snapshot.appendItems(homeVM.homePostData?.customizedPostData ?? [], toSection: .customized)
        snapshot.appendItems(homeVM.homePostData?.editorRecommendationPostData ?? [], toSection: .editorRecommendation)
        dataSource.apply(snapshot)
    }
    
    private func setUpHierarchy() {
        self.addSubview(collectionView)
    }
    
    private func setUpLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self.createOneItemSection()
            case 1, 2, 3:
                return self.createHorizontalSection()
            default:
                return self.createVerticalSection()
            }
        }
    }
    
    // 셀간 간격: group.interItemSpacing
    // 그룹간 간격: section.interGroupSpacing
    
    private func createOneItemSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(hometodayPickViewWidth), heightDimension: .absolute(hometodayPickViewHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(hometodayPickViewWidth), heightDimension: .absolute(hometodayPickViewHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 35, trailing: 15)
        let headerSize = NSCollectionLayoutSize(widthDimension: .absolute(screenWidth), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(homeHorizontalCVCLength), heightDimension: .absolute(homeHorizontalCVCLength))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(homeHorizontalCVCLength), heightDimension: .absolute(homeHorizontalCVCLength))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 60, trailing: 15)
        section.interGroupSpacing = 15
        let headerSize = NSCollectionLayoutSize(widthDimension: .absolute(screenWidth), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(homeEditorRecommendCVCLength), heightDimension: .absolute(homeEditorRecommendCVCLength))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(homeEditorRecommendCVCLength), heightDimension: .absolute(homeEditorRecommendCVCLength))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        section.interGroupSpacing = 20
        let headerSize = NSCollectionLayoutSize(widthDimension: .absolute(screenWidth), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

extension HomeContentsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let post = dataSource.itemIdentifier(for: indexPath) {
            homeVM.sendInputEvent(input: .postTapped(post))
        }
    }
}
