//
//  TabBarItem.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

enum TabBarItem {
    case home, search, library

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
