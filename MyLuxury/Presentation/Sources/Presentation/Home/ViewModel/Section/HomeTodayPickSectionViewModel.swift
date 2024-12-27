//
//  Untitled.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeTodayPickSectionViewModel: HomeSectionViewModel {
    var sectionHeaderVM = HomeSectionHeaderViewModel()
    var sectionCellVM = HomeTodayPickCVCViewModel()
    
    init() {
        print("HomeTodayPickSectionViewModel init")
    }
    
    deinit {
        print("HomeTodayPickSectionViewModel deinit")
    }
}
