//
//  HomeWeeklyTopSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeWeeklyTopSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    let sectionCellVM = HomeHorizontalCVCViewModel()
    
    init() {
        print("HomeWeeklyTopSectionViewModel init")
    }
    
    deinit {
        print("HomeWeeklyTopSectionViewModel deinit")
    }
}
