//
//  HomeContentsView.swift
//  Presentation
//
//  Created by KoSungmin on 10/28/24.
//

import UIKit
import Combine
import Domain

struct CompositeViewModel {
    let headerVM: HomeSectionHeaderViewModel
    let cellVMs: [HomeSectionCellViewModel]
}

enum HomeSectionHeaderViewModel: Hashable, Identifiable {
    case todayPick(headerVM: HomeSectionHeaderView.ViewModel)
    case newPost(headerVM: HomeSectionHeaderView.ViewModel)
    case weeklyTop(headerVM: HomeSectionHeaderView.ViewModel)
    case customized(headerVM: HomeSectionHeaderView.ViewModel)
    case editorRecommend(headerVM: HomeSectionHeaderView.ViewModel)
    
    var id: String {
        switch self {
        case .todayPick:
            return "todayPick"
        case .newPost:
            return "newPost"
        case .weeklyTop:
            return "weeklyTop"
        case .customized:
            return "customized"
        case .editorRecommend:
            return "editorRecommend"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HomeSectionHeaderViewModel, rhs: HomeSectionHeaderViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

enum HomeSectionCellViewModel: Hashable, Sendable {
    case todayPick(cellVM: HomeTodayPickCVC.ViewModel)
    case newPost(cellVM: HomeHorizontalCVC.ViewModel)
    case weeklyTop(cellVM: HomeHorizontalCVC.ViewModel)
    case customized(cellVM: HomeHorizontalCVC.ViewModel)
    case editorRecommend(cellVM: HomeEditorRecommendCVC.ViewModel)
}


final class HomeContentsView: UIView {
    struct ViewModel {
        let sections: [CompositeViewModel]
    }
    
    private var homeVM: HomeViewModel
    
    private lazy var collectionView: UICollectionView = {
        // collectionView의 레이아웃을 하단에서 생성한 CompositionalLayout 방식으로 지정
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<HomeSectionHeaderViewModel, HomeSectionCellViewModel> = {
        var dataSource = UICollectionViewDiffableDataSource<HomeSectionHeaderViewModel, HomeSectionCellViewModel>(collectionView: collectionView) {
            collectionView, indexPath, cellViewModel in
            switch cellViewModel {
            case .todayPick(cellVM: let cellVM):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTodayPickCVC.identifier, for: indexPath) as! HomeTodayPickCVC
                cell.configure(viewModel: cellVM)
                return cell
            case .newPost(cellVM: let cellVM):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHorizontalCVC.identifier, for: indexPath) as! HomeHorizontalCVC
                cell.configure(viewModel: cellVM)
                return cell
            case .weeklyTop(cellVM: let cellVM):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHorizontalCVC.identifier, for: indexPath) as! HomeHorizontalCVC
                cell.configure(viewModel: cellVM)
                return cell
            case .customized(cellVM: let cellVM):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHorizontalCVC.identifier, for: indexPath) as! HomeHorizontalCVC
                cell.configure(viewModel: cellVM)
                return cell
            case .editorRecommend(cellVM: let cellVM):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEditorRecommendCVC.identifier, for: indexPath) as! HomeEditorRecommendCVC
                cell.configure(viewModel: cellVM)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeSectionHeaderView.identifier,
                for: indexPath) as! HomeSectionHeaderView
            
            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .todayPick(headerVM: let headerVM):
                headerView.configure(viewModel: headerVM)
            case .newPost(headerVM: let headerVM):
                headerView.configure(viewModel: headerVM)
            case .weeklyTop(headerVM: let headerVM):
                headerView.configure(viewModel: headerVM)
            case .customized(headerVM: let headerVM):
                headerView.configure(viewModel: headerVM)
            case .editorRecommend(headerVM: let headerVM):
                headerView.configure(viewModel: headerVM)
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
        collectionView.register(HomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.identifier)
        collectionView.register(HomeTodayPickCVC.self, forCellWithReuseIdentifier: HomeTodayPickCVC.identifier)
        collectionView.register(HomeHorizontalCVC.self, forCellWithReuseIdentifier: HomeHorizontalCVC.identifier)
        collectionView.register(HomeEditorRecommendCVC.self, forCellWithReuseIdentifier: HomeEditorRecommendCVC.identifier)
    }

    func configureSnapshot(viewModel: ViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSectionHeaderViewModel, HomeSectionCellViewModel>()
        viewModel.sections.forEach { viewModel in
            snapshot.appendSections([viewModel.headerVM])
            snapshot.appendItems(viewModel.cellVMs, toSection: viewModel.headerVM)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
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
            let section = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            switch section {
            case .todayPick:
                return self.createOneItemSection()
            case .newPost:
                return self.createHorizontalSection()
            case .weeklyTop:
                return self.createHorizontalSection()
            case .customized:
                return self.createHorizontalSection()
            case .editorRecommend:
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
            switch post {
            case .todayPick(cellVM: let cellVM):
                homeVM.sendInputEvent(input: .postTapped(cellVM.homePostTemplate.postId))
            case .newPost(cellVM: let cellVM):
                homeVM.sendInputEvent(input: .postTapped(cellVM.homePostTemplate.postId))
            case .weeklyTop(cellVM: let cellVM):
                homeVM.sendInputEvent(input: .postTapped(cellVM.homePostTemplate.postId))
            case .customized(cellVM: let cellVM):
                homeVM.sendInputEvent(input: .postTapped(cellVM.homePostTemplate.postId))
            case .editorRecommend(cellVM: let cellVM):
                homeVM.sendInputEvent(input: .postTapped(cellVM.homePostTemplate.postId))
            }
        }
    }
}
