//
//  HomeContentsView.swift
//  Presentation
//
//  Created by KoSungmin on 10/28/24.
//

import UIKit
import Combine
import Domain

final class HomeContentsView: UIView {
    private var homeVM: HomeViewModel
    
    private lazy var collectionView: UICollectionView = {
        // collectionView의 레이아웃을 하단에서 생성한 CompositionalLayout 방식으로 지정
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomePostViewTemplate> = {
        // 각 섹션의 셀에 어떤 데이터가 들어갈 것인지를 결정
        var dataSource = UICollectionViewDiffableDataSource<HomeSection, HomePostViewTemplate>(collectionView: collectionView) {
            // post는 제네릭 타입으로 주어진 HomePostViewTemplate의 인스턴스를 의미
            collectionView, indexPath, post in
            /// 섹션의 순서를 가져온 배열. 섹션의 순서는 사용자마자 다를 수 있음.
            let section = HomeSection.allCases[indexPath.section]
            switch section {
            case .todayPick:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTodayPickCVC.identifier, for: indexPath) as! HomeTodayPickCVC
                cell.homePostViewData = post
                return cell
            case .editorRecommendation:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEditorRecommendCVC.identifier, for: indexPath) as! HomeEditorRecommendCVC
                cell.homePostViewData = post
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHorizontalCVC.identifier, for: indexPath) as! HomeHorizontalCVC
                cell.homePostViewData = post
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: HomeContentsSectionHeaderView.identifier,
                                                                             for: indexPath) as! HomeContentsSectionHeaderView
            let section = HomeSection.allCases[indexPath.section]
            switch section {
            case .todayPick:
                let sectionHeaderVM = (self.homeVM.homeCVVM.homeSectionVMs.first(where: { $0 is HomeTodayPickSectionViewModel }) as? HomeTodayPickSectionViewModel)?.sectionHeaderVM
                headerView.sectionTitle = sectionHeaderVM?.sectionTitle
            case .new:
                let sectionHeaderVM = (self.homeVM.homeCVVM.homeSectionVMs.first(where: { $0 is HomeNewPostsSectionViewModel }) as? HomeNewPostsSectionViewModel)?.sectionHeaderVM
                headerView.sectionTitle = sectionHeaderVM?.sectionTitle
            case .weeklyTop:
                let sectionHeaderVM = (self.homeVM.homeCVVM.homeSectionVMs.first(where: { $0 is HomeWeeklyTopSectionViewModel }) as? HomeWeeklyTopSectionViewModel)?.sectionHeaderVM
                headerView.sectionTitle = sectionHeaderVM?.sectionTitle
            case .customized:
                let sectionHeaderVM = (self.homeVM.homeCVVM.homeSectionVMs.first(where: { $0 is HomeCustomizedSectionViewModel }) as? HomeCustomizedSectionViewModel)?.sectionHeaderVM
                headerView.sectionTitle = sectionHeaderVM?.sectionTitle
            case .editorRecommendation:
                let sectionHeaderVM = (self.homeVM.homeCVVM.homeSectionVMs.first(where: { $0 is HomeEditorRecommendSectionViewModel }) as? HomeEditorRecommendSectionViewModel)?.sectionHeaderVM
                headerView.sectionTitle = sectionHeaderVM?.sectionTitle
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
        // 스냅샷 정의 부분에서 초기 데이터 모습을 결정. -> 섹션의 순서를 결정
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomePostViewTemplate>()
        snapshot.appendSections(self.homeVM.homeCVVM.sectionIndex)
        for sectionVM in homeVM.homeCVVM.homeSectionVMs {
            if let todayPickVM = sectionVM as? HomeTodayPickSectionViewModel {
                snapshot.appendItems(todayPickVM.posts, toSection: .todayPick)
            } else if let newPostsVM = sectionVM as? HomeNewPostsSectionViewModel {
                snapshot.appendItems(newPostsVM.posts, toSection: .new)
            } else if let weeklyTopVM = sectionVM as? HomeWeeklyTopSectionViewModel {
                snapshot.appendItems(weeklyTopVM.posts, toSection: .weeklyTop)
            } else if let customizedVM = sectionVM as? HomeCustomizedSectionViewModel {
                snapshot.appendItems(customizedVM.posts, toSection: .customized)
            } else if let editorRecommendVM = sectionVM as? HomeEditorRecommendSectionViewModel {
                snapshot.appendItems(editorRecommendVM.posts, toSection: .editorRecommendation)
            }
        }
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
            let section = HomeSection.allCases[sectionIndex]
            switch section {
            case .todayPick:
                return self.createOneItemSection()
            case .editorRecommendation:
                return self.createVerticalSection()
            default:
                return self.createHorizontalSection()
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
            homeVM.sendInputEvent(input: .postTapped(post.postId))
        }
    }
}
