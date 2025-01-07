//
//  HomeCVViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

import UIKit
import Domain

protocol HomeSectionViewModel: AnyObject {
    
}

final class HomeCVViewModel {
    var sectionOrder: [HomeSection] = []
    var homeSectionVMs: [HomeSectionViewModel] = []

    init() {
        print("HomeCVViewModel init")
    }
    
    deinit {
        print("HomeCVViewModel deinit")
    }
    
    func setHomeData(homePostData: HomePostViewTemplateGroup) {
        if let sectionOrder = homePostData.sectionOrder {
            self.sectionOrder = sectionOrder
            for sectioin in sectionOrder {
                switch sectioin {
                case .todayPick:
                    if let posts = homePostData.todayPickPostData {
                        homeSectionVMs.append(HomeTodayPickSectionViewModel(posts: posts))
                    }
                case .new:
                    if let posts = homePostData.newPostData {
                        homeSectionVMs.append(HomeNewPostsSectionViewModel(posts: posts))
                    }
                case .weeklyTop:
                    if let posts = homePostData.weeklyTopPostData {
                        homeSectionVMs.append(HomeWeeklyTopSectionViewModel(posts: posts))
                    }
                case .customized:
                    if let posts = homePostData.customizedPostData {
                        homeSectionVMs.append(HomeCustomizedSectionViewModel(posts: posts))
                    }
                case .editorRecommendation:
                    if let posts = homePostData.editorRecommendationPostData {
                        homeSectionVMs.append(HomeEditorRecommendSectionViewModel(posts: posts))
                    }
                }
            }
        }
    }
}
