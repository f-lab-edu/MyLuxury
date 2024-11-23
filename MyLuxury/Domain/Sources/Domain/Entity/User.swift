//
//  User.swift
//  Domain
//
//  Created by KoSungmin on 11/20/24.
//

import Foundation

public struct User {
    /// 사용자 식별 아이디
    public let userId: String
    /// 사용자 닉네임
    public let userNickname: String
    /// 사용자 이메일
    public let userEmail: String
    /// 사용자 등급
    public let userGrade: UserGrade
}
