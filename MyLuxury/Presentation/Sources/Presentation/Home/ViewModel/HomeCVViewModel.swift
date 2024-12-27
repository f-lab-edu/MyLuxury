//
//  HomeCVViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

import UIKit
import Domain

protocol HomeSectionViewModel {
    
}

final class HomeCVViewModel {
    var homePostData: HomePostViewTemplateGroup? = nil
    lazy var homeSectionVMs: [HomeSection: HomeSectionViewModel] = [:]

    init() {
        print("HomeCVViewModel init")
//        setHomeData()
    }
    
    deinit {
        print("HomeCVViewModel deinit")
    }
    
    func setHomeData(sectionIndex: [HomeSection]) {
        homePostData?.sectionIndex = sectionIndex
        if let todayPickPost = homePostData?.todayPickPostData {
            let vm = HomeTodayPickSectionViewModel()
            vm.sectionHeaderVM.sectionTitle = HomeSection.todayPick.rawValue
            vm.sectionCellVM.post = todayPickPost
            homeSectionVMs[.todayPick] = vm
        }
        if let newPosts = homePostData?.newPostData {
            let vm = HomeNewPostsSectionViewModel()
            vm.sectionHeaderVM.sectionTitle = HomeSection.new.rawValue
            vm.sectionCellVM.posts = newPosts
            homeSectionVMs[.new] = vm
        }
        if let weeklyTopPosts = homePostData?.weeklyTopPostData {
            let vm = HomeWeeklyTopSectionViewModel()
            vm.sectionHeaderVM.sectionTitle = HomeSection.weeklyTop.rawValue
            vm.sectionCellVM.posts = weeklyTopPosts
            homeSectionVMs[.weeklyTop] = vm
        }
        if let customizedPosts = homePostData?.customizedPostData {
            let vm = HomeCustomizedSectionViewModel()
            vm.sectionHeaderVM.sectionTitle = HomeSection.customized.rawValue
            vm.sectionCellVM.posts = customizedPosts
            homeSectionVMs[.customized] = vm
        }
        if let editorRecommendPosts = homePostData?.editorRecommendationPostData {
            let vm = HomeEditorRecommendSectionViewModel()
            vm.sectionHeaderVM.sectionTitle = HomeSection.editorRecommendation.rawValue
            vm.sectionCellVM.posts = editorRecommendPosts
            homeSectionVMs[.editorRecommendation] = vm
        }
    }
}
