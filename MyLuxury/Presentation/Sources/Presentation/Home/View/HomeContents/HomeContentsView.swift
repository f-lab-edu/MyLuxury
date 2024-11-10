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
    var homeVM: HomeViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 30
        return stackView
    }()
    
    /// 새로운 섹션을 추가하기 위해서 이곳과 HomeContentsSectionType에 case를 추가해야 합니다. 
    lazy var contentsSections: [HomeContentsSectionView] = [
        HomeTodayPickView(homeVM: homeVM, sectionTitle: "오늘의 PICK"),
        HomeHorizontalCollectionView(homeVM: homeVM, sectionTitle: "새로 게시된 지식"),
        HomeHorizontalCollectionView(homeVM: homeVM, sectionTitle: "이번 주 TOP10"),
        HomeHorizontalCollectionView(homeVM: homeVM, sectionTitle: "회원님이 좋아할 만한"),
        HomeEditorRecommendCollectionView(homeVM: homeVM, sectionTitle: "에디처 추천 지식")
    ]

    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        super.init(frame: .zero)
        setUpHierarchy()
        setUpLayout()
        scrollView.backgroundColor = .black
        stackView.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        for sectionView in contentsSections {
            stackView.addArrangedSubview(sectionView as? UIView ?? UIView())
        }
    }
    
    private func setUpLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    func getSectionView(type: HomeContentsSectionType) -> HomeContentsSectionView {
        return contentsSections[type.rawValue]
    }
}
