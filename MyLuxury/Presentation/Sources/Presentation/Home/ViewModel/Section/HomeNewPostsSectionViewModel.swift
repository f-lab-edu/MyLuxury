//
//  HomeNewPostsSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeNewPostsSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    let sectionCellVM = HomeHorizontalCVCViewModel()
    
    init() {
        print("HomeNewPostsSectionViewModel init")
    }
    
    deinit {
        print("HomeNewPostsSectionViewModel deinit")
    }
}
