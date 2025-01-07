//
//  Untitled.swift
//  Presentation
//
//  Created by KoSungmin on 12/24/24.
//

final class HomeTodayPickSectionViewModel: HomeSectionViewModel {
    var sectionHeaderVM = HomeSectionHeaderViewModel()
    var posts: [HomePostViewTemplate] = []
    
    init() {
        print("HomeTodayPickSectionViewModel init")
        self.sectionHeaderVM.sectionTitle = "오늘의 PICK"
    }
    
    deinit {
        print("HomeTodayPickSectionViewModel deinit")
    }
}
