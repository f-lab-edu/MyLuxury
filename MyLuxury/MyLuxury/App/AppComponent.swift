//
//  AppComponent.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Foundation

/// 앱 실행 시 필요한 구현체들을 미리 만들어놓는 클래스입니다.
/// DIContainer의 역할을 합니다.
public class AppComponent {
    
    let urlSession: URLSession
    let memberRepository: MemberRepository
    let postRepository: PostRepository
    let memberUseCase: MemberUseCase
    let postUseCase: PostUseCase
    
    /// 다른 인스턴스로 실행하고 싶다면 이 생성자에서 해당하는 인스턴스로 바꿔주시면 됩니다.
    public init() {
        self.urlSession = URLSession.shared
        self.memberRepository = MemberRepositoryImpl()
        self.postRepository = PostRepositoryImpl()
        self.memberUseCase = MemberUseCase(memberRepository: self.memberRepository)
        self.postUseCase = PostUseCase(postRepository: self.postRepository)
    }
}
