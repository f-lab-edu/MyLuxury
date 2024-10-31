//
//  PostRepositoryImpl.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine
import Domain

public class PostRepositoryImpl: PostRepository {
   
    public init() {
        print("PostRepositoryImpl init")
    }
    
    public func getHomeViewData() -> AnyPublisher<Domain.HomePostData, Never> {
        let homePostData: HomePostData = (
            todayPickPostData: Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1"),
            newPostData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1")
            ],
            weeklyTopPostData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1")
            ],
            customizedPostData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1")
            ],
            editorRecommendationPostData: [
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1"),
                Post(post_id: "123", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage1")
            ]
        )
        
        return Just(homePostData).eraseToAnyPublisher()
    }
}
