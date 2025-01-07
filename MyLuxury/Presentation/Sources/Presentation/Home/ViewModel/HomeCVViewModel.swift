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
    var sectionOrder: [HomeSectionTemplate] = []
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
            for section in sectionOrder {
                switch section {
                case .todayPick(let vm):
                    if let posts = homePostData.todayPickPostData {
                        vm.posts = posts
                        homeSectionVMs.append(vm)
                    }
                case .new(let vm):
                    if let posts = homePostData.newPostData {
                        vm.posts = posts
                        homeSectionVMs.append(vm)
                    }
                case .weeklyTop(let vm):
                    if let posts = homePostData.weeklyTopPostData {
                        vm.posts = posts
                        homeSectionVMs.append(vm)
                    }
                case .customized(let vm):
                    if let posts = homePostData.customizedPostData {
                        vm.posts = posts
                        homeSectionVMs.append(vm)
                    }
                case .editorRecommendation(let vm):
                    if let posts = homePostData.editorRecommendationPostData {
                        vm.posts = posts
                        homeSectionVMs.append(vm)
                    }
                }
            }
        }
    }
}
