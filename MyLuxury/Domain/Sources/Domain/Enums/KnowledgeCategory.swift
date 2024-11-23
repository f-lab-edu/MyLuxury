//
//  KnowledgeCategory.swift
//  Domain
//
//  Created by KoSungmin on 10/28/24.
//

/// 지식의 카테고리 enum
public enum KnowledgeCategory {
    case history, music, sports, art, science, culture, economy, general, humanity, geography
    
    public var name: String {
        switch self {
        case .history:
            return "역사"
        case .music:
            return "음악"
        case .sports:
            return "스포츠"
        case .art:
            return "미술"
        case .science:
            return "과학"
        case .culture:
            return "문화"
        case .economy:
            return "경제"
        case .general:
            return "일반"
        case .humanity:
            return "인문학"
        case .geography:
            return "지리"
        }
    }
    
    public var tagName: String {
        switch self {
        case .history:
            return "#역사"
        case .music:
            return "#음악"
        case .sports:
            return "#스포츠"
        case .art:
            return "#미술"
        case .science:
            return "#과학"
        case .culture:
            return "#문화"
        case .economy:
            return "#경제"
        case .general:
            return "#일반"
        case .humanity:
            return "#인문"
        case .geography:
            return "#지리"
        }
    }
}
