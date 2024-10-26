//
//  TabBarItem.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

enum TabBarItem {
    case home, search, library
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .search:
            return "검색"
        case .library:
            return "내 라이브러리"
        }
    }
    
    var image: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .library:
            return "book"
        }
    }
}
