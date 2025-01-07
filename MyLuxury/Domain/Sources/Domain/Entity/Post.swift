//
//  Post.swift
//  Domain
//
//  Created by KoSungmin on 10/31/24.
//

import Foundation

public struct Post: @unchecked Sendable {
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
    /// 게시물 이미지 출처
    public var postImageSources: [String]?
    /// 게시물 내용
    public var postContents: [String]?
    /// 게시물 작성자
    public var postEditor: String?
    /// 게시물 작성자 프로필 사진
    public var postEditorProfileImage: String?
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
    
    public init(post_id: String, postUIType: PostUIType, postCategory: KnowledgeCategory, postTitle: String, postThumbnailImage: String, postImages: [String]? = nil, postImageSources: [String]? = nil, postContents: [String]? = nil, postEditor: String? = nil, postEditorProfileImage: String?, postView: Int? = nil, postCreatedAt: Date? = nil, postUpdatedAt: Date? = nil) {
        self.post_id = post_id
        self.postUIType = postUIType
        self.postCategory = postCategory
        self.postTitle = postTitle
        self.postThumbnailImage = postThumbnailImage
        self.postImages = postImages
        self.postImageSources = postImageSources
        self.postContents = postContents
        self.postEditorProfileImage = postEditorProfileImage
        self.postEditor = postEditor
        self.postView = postView
        self.postCreatedAt = postCreatedAt
        self.postUpdatedAt = postUpdatedAt
    }
}

extension Post: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(post_id)
    }
    
    public static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.post_id == rhs.post_id
    }
}

public enum HomeSection: String, CaseIterable, @unchecked Sendable {
    case todayPick = "오늘의 Pick"
    case new = "새로 게시된 지식"
    case weeklyTop = "이번 주 TOP10"
    case customized = "회원님이 좋아할만한"
    case editorRecommendation = "에디터 추천 지식"
}

public struct HomePostData {
    public var sectionOrder: [HomeSection]?
    public var todayPickPostData: [Post]?
    public var newPostData: [Post]?
    public var weeklyTopPostData: [Post]?
    public var customizedPostData: [Post]?
    public var editorRecommendationPostData: [Post]?
    
    public init(
        sectionOrder: [HomeSection]? = nil,
        todayPickPostData: [Post]? = nil,
        newPostData: [Post]? = nil,
        weeklyTopPostData: [Post]? = nil,
        customizedPostData: [Post]? = nil,
        editorRecommendationPostData: [Post]? = nil
    ) {
        self.sectionOrder = sectionOrder
        self.todayPickPostData = todayPickPostData
        self.newPostData = newPostData
        self.weeklyTopPostData = weeklyTopPostData
        self.customizedPostData = customizedPostData
        self.editorRecommendationPostData = editorRecommendationPostData
    }
}
