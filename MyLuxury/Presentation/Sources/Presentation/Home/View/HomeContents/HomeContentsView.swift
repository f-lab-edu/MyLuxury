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
    
    var homePostData: HomePostData? {
        didSet {
            updateContentsSections()
        }
    }

    private var contentsSections: [any HomeContentsSectionView] = []
    
    /// 섹션 추가는 이 곳에서 하시면 됩니다.
    private func updateContentsSections() {
        if let data = homePostData?.todayPickPostData {
            contentsSections.append(HomeTodayPickView(homeVM: homeVM, sectionTitle: "오늘의 PICK", postData: data))
        }
        if let data = homePostData?.newPostData {
            contentsSections.append(HomeHorizontalCollectionView(homeVM: homeVM, sectionTitle: "새로 게시된 지식", postData: data))
        }
        if let data = homePostData?.weeklyTopPostData {
            contentsSections.append(HomeHorizontalCollectionView(homeVM: homeVM, sectionTitle: "이번 주 TOP10", postData: data))
        }
        if let data = homePostData?.customizedPostData {
            contentsSections.append(HomeHorizontalCollectionView(homeVM: homeVM, sectionTitle: "회원님이 좋아할 만한", postData: data))
        }
        if let data = homePostData?.editorRecommendationPostData {
            contentsSections.append(HomeEditorRecommendCollectionView(homeVM: homeVM, sectionTitle: "에디터 추천 지식", postData: data))
        }

        for section in contentsSections {
            stackView.addArrangedSubview(section)
        }
    }

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
}
