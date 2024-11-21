//
//  UserGrade.swift
//  Domain
//
//  Created by KoSungmin on 11/20/24.
//

/// 앱 사용자 등급. 상위 등급은 하위 등급의 권한을 포함
public enum UserGrade: String {
    /// 앱 관리자
    case master = "master"
    /// 지식 게시물 작성 가능자
    case writer = "writer"
    /// 일반 사용자
    case normal = "normal"
}
