//
//  HomeWeeklyTopSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeWeeklyTopSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    var posts: [HomePostViewTemplate] = []
    
    init(posts: [HomePostViewTemplate]) {
        print("HomeWeeklyTopSectionViewModel init")
        self.posts = posts
        self.sectionHeaderVM.sectionTitle = "이번 주 TOP10"
    }
    
    deinit {
        print("HomeWeeklyTopSectionViewModel deinit")
    }
}
