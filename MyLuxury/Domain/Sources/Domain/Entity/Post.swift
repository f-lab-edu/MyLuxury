//
//  Post.swift
//  Domain
//
//  Created by KoSungmin on 10/31/24.
//

import Foundation

public struct Post {
    /// 게시물 식별 아이디
    public let post_id: String
    /// 게시물 UI 타입. 추후 종류가 추가될 예정
    public let postUIType: PostUIType
    /// 게시물 카테고리
    public let postCategory: KnowledgeCategory
    /// 게시물 제목
    public let postTitle: String
    /// 게시물 썸네일
    public let postThumbnailImage: String
    /// 게시물 이미지들
    public var postImages: [String]?
    /// 게시물 내용
    public var postContents: [String]?
    /// 게시물 작성자
    public var postEditor: String?
    /// 게시물 조회수
    public var postView: Int?
    /// 게시물 작성일
    public var postCreatedAt: Date?
    /// 게시물 수정일
    public var postUpdatedAt: Date?
    
    public init(post_id: String, postUIType: PostUIType, postCategory: KnowledgeCategory, postTitle: String, postThumbnailImage: String) {
        self.post_id = post_id
        self.postUIType = postUIType
        self.postCategory = postCategory
        self.postTitle = postTitle
        self.postThumbnailImage = postThumbnailImage
    }
    
    public init(post_id: String, postUIType: PostUIType, postCategory: KnowledgeCategory, postTitle: String, postThumbnailImage: String, postImages: [String]? = nil, postContents: [String]? = nil, postEditor: String? = nil, postView: Int? = nil, postCreatedAt: Date? = nil, postUpdatedAt: Date? = nil) {
        self.post_id = post_id
        self.postUIType = postUIType
        self.postCategory = postCategory
        self.postTitle = postTitle
        self.postThumbnailImage = postThumbnailImage
        self.postImages = postImages
        self.postContents = postContents
        self.postEditor = postEditor
        self.postView = postView
        self.postCreatedAt = postCreatedAt
        self.postUpdatedAt = postUpdatedAt
    }
}

/// 홈 메인 화면 데이터 모음을 정의한 typealias
public typealias HomePostData = (
    todayPickPostData: Post,
    newPostData: [Post],
    weeklyTopPostData: [Post],
    customizedPostData: [Post],
    editorRecommendationPostData: [Post]
)
