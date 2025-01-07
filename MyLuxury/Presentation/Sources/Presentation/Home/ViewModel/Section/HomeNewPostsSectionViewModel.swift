//
//  HomeNewPostsSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeNewPostsSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    var posts: [HomePostViewTemplate] = []
    
    init() {
        print("HomeNewPostSectionViewModel init")
        self.sectionHeaderVM.sectionTitle = "새로 게시된 지식"
    }

    deinit {
        print("HomeNewPostsSectionViewModel deinit")
    }
}
