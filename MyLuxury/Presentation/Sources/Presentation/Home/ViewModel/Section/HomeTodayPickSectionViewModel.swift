//
//  Untitled.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeTodayPickSectionViewModel: HomeSectionViewModel {
    var sectionHeaderVM = HomeSectionHeaderViewModel()
    var posts: [HomePostViewTemplate] = []
    
    init(posts: [HomePostViewTemplate]) {
        print("HomeTodayPickSectionViewModel init")
        self.posts = posts
        self.sectionHeaderVM.sectionTitle = "오늘의 Pick"
    }
    
    deinit {
        print("HomeTodayPickSectionViewModel deinit")
    }
}
