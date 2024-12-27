//
//  HomeCustomizedSectionViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeCustomizedSectionViewModel: HomeSectionViewModel {
    let sectionHeaderVM = HomeSectionHeaderViewModel()
    let sectionCellVM = HomeHorizontalCVCViewModel()
    
    init() {
        print("HomeCustomizedSectionViewModel init")
    }
    
    deinit {
        print("HomeCustomizedSectionViewModel deinit")
    }
}
