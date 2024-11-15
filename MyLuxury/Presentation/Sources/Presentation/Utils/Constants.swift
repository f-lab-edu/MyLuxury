//
//  Constants.swift
//  Presentation
//
//  Created by KoSungmin on 10/27/24.
//

import UIKit

/// 디바이스 너비
@MainActor let screenWidth = UIScreen.main.bounds.width
/// 디바이스 높이
@MainActor let screenHeight = UIScreen.main.bounds.height
/// 상단 네비게이션바 높이
@MainActor let navigationBarHeight = screenHeight/14
/// 홈 화면 오늘의 픽뷰의 너비
@MainActor let hometodayPickViewWidth = screenWidth - 30
/// 홈 화면 오늘의 픽뷰의 높이
@MainActor let hometodayPickViewHeight = hometodayPickViewWidth/2.5
/// 홈 화면 가로 컬렉션뷰 셀 변의 길이
@MainActor let homeHorizontalCVCLength = screenWidth/3
/// 홈 화면 2*2 그리드 컬렉션뷰 셀의 너비
@MainActor let homeGridCVCWidth = (screenWidth-45)/2
/// 홈 화면 2*2 그리드 컬렉션뷰 셀의 높이
@MainActor let homeGridCVCHeight = homeGridCVCWidth / 1.77
/// 홈 화면 에디터 추천 컬렉션 뷰 셀 변의 길이
@MainActor let homeEditorRecommendCVCLength = screenWidth - 30
