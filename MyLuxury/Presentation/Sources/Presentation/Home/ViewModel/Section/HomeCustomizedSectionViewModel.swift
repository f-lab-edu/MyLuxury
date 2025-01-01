//
//  HomeCustomizedSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeCustomizedSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    var posts: [HomePostViewTemplate] = []
    
    init(posts: [HomePostViewTemplate]) {
        print("HomeCustomizedSectionViewModel init")
        self.posts = posts
        self.sectionHeaderVM.sectionTitle = "회원님이 좋아할만한"
    }
    
    deinit {
        print("HomeCustomizedSectionViewModel deinit")
    }
}
