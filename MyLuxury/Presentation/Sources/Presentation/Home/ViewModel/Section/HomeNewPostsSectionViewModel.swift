//
//  HomeNewPostsSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeNewPostsSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    var posts: [HomePostViewTemplate] = []
    
    init(posts: [HomePostViewTemplate]) {
        print("HomeNewPostsSectionViewModel init")
        self.posts = posts
        self.sectionHeaderVM.sectionTitle = "새로운 게시된 지식"
    }
    
    deinit {
        print("HomeNewPostsSectionViewModel deinit")
    }
}
