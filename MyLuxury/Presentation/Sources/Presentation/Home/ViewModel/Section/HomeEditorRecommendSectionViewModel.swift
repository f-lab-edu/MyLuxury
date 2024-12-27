//
//  HomeEditorRecommendSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeEditorRecommendSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    let sectionCellVM = HomeEditorRecommendCVCViewModel()
    
    init() {
        print("HomeEditorRecommendSectionViewModel init")
    }
    
    deinit {
        print("HomeEditorRecommendSectionViewModel deinit")
    }
}
