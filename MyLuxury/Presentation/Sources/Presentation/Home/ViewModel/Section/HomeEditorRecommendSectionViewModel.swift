//
//  HomeEditorRecommendSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeEditorRecommendSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    var posts: [HomePostViewTemplate] = []
    
    init() {
        print("HomeEditorRecommendSectionViewModel init")
        self.sectionHeaderVM.sectionTitle = "에디터 추천 지식"
    }
    
    deinit {
        print("HomeEditorRecommendSectionViewModel deinit")
    }
}
