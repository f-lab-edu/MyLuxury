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
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 30
        return stackView
    }()
    
    let homeTodayPickView: HomeTodayPickView = {
        let view = HomeTodayPickView()
        return view
    }()
    
    let newPostsCV: HomeHorizontalCollectionView = {
        let cv = HomeHorizontalCollectionView()
        cv.title = "새로 게시된 지식"
        return cv
    }()
    
    let weeklyTopPostsCV: HomeHorizontalCollectionView = {
        let cv = HomeHorizontalCollectionView()
        cv.title = "이번 주 TOP10"
        return cv
    }()
    
    let preferPostCV: HomeHorizontalCollectionView = {
        let cv = HomeHorizontalCollectionView()
        cv.title = "회원님이 좋아할 만한"
        return cv
    }()
    
//    let homeGridCV: HomeGridCollectionView = {
//        let cv = HomeGridCollectionView()
//        cv.title = "회원님이 좋아할 만한"
//        return cv
//    }()
    
    let homeEditorRecommendCV: HomeEditorRecommendCollectionView = {
        let cv = HomeEditorRecommendCollectionView()
        cv.title = "에디터 추천 지식"
        return cv
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
        scrollView.backgroundColor = .black
        stackView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(homeTodayPickView)
        stackView.addArrangedSubview(newPostsCV)
        stackView.addArrangedSubview(weeklyTopPostsCV)
//        stackView.addArrangedSubview(homeGridCV)
        stackView.addArrangedSubview(preferPostCV)
        stackView.addArrangedSubview(homeEditorRecommendCV)
    }
    
    private func setUpLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        homeTodayPickView.translatesAutoresizingMaskIntoConstraints = false
        newPostsCV.translatesAutoresizingMaskIntoConstraints = false
        weeklyTopPostsCV.translatesAutoresizingMaskIntoConstraints = false
//        homeGridCV.translatesAutoresizingMaskIntoConstraints = false
        preferPostCV.translatesAutoresizingMaskIntoConstraints = false
        homeEditorRecommendCV.translatesAutoresizingMaskIntoConstraints = false

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
            homeTodayPickView.topAnchor.constraint(equalTo: stackView.topAnchor),
            homeTodayPickView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            newPostsCV.topAnchor.constraint(equalTo: homeTodayPickView.bottomAnchor, constant: 30),
            weeklyTopPostsCV.topAnchor.constraint(equalTo: newPostsCV.bottomAnchor, constant: 30),
            preferPostCV.topAnchor.constraint(equalTo: weeklyTopPostsCV.bottomAnchor, constant: 30),
//            homeGridCV.topAnchor.constraint(equalTo: weeklyTopPostsCV.bottomAnchor, constant: 30),
//            homeGridCV.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            homeEditorRecommendCV.topAnchor.constraint(equalTo: preferPostCV.bottomAnchor, constant: 30),
            homeEditorRecommendCV.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
}
