//
//  PostRepositoryMockImpl.swift
//  Data
//
//  Created by KoSungmin on 10/31/24.
//

import Foundation
import Combine
import Domain

public class PostRepositoryMockImpl: PostRepository {
    public func getHomeViewData() -> AnyPublisher<HomePostData, Never> {
        let homePostData: HomePostData = (
            todayPickPostData: Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까???", postThumbnailImage: "testImage1"),
            newPostData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2")
            ],
            weeklyTopPostData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7")
            ],
            customizedPostData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
            ],
            gridData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
            ],
            editorRecommendationPostData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8")
            ]
        )
        return Just(homePostData).eraseToAnyPublisher()
    }
    
    public init() { }
}
