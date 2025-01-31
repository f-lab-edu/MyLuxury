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
    public init() {
        print("PostRepositoryImpl init")
    }
    
    public func getHomeViewData() -> AnyPublisher<HomePostData, Never> {
        let homePostData: HomePostData = (
            todayPickPostData: Post(post_id: "1", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까???", postThumbnailImage: "testImage1"),
            newPostData: [
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2")
            ],
            weeklyTopPostData: [
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
                Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7")
            ],
            customizedPostData: [
                Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
                Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
                Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
                Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
            ],
            gridData: [
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
                Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
            ],
            editorRecommendationPostData: [
                Post(post_id: "5", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
                Post(post_id: "6", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
                Post(post_id: "7", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
                Post(post_id: "8", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8")
            ]
        )
        return Just(homePostData).eraseToAnyPublisher()
    }
    
    public func getPostOneData(postId: String) -> AnyPublisher<Post, Never> {
        let postData: [Post] = [
            Post(post_id: "1",
                 postUIType: .normal,
                 postCategory: .culture,
                 postTitle: "흑백 사진은 언제 처음 사용됐을까?",
                 postThumbnailImage: "testImage1",
                 postImages: ["testImage1", "testImage1", "testImage1", "testImage1"],
                 postImageSources: ["이미지 출처", "이미지 출처", "이미지 출처", "이미지 출처"],
                 postContents: ["testImage1", "testImage1", "testImage1", "testImage1"],
                 postEditor: "에디터 이름",
                 postEditorProfileImage: "profileImage",
                 postView: 1132,
                 postCreatedAt: Date(),
                 postUpdatedAt: Date()
                ),
            Post(post_id: "2",
                 postUIType: .normal,
                 postCategory: .culture,
                 postTitle: "그때 그 시절, 무엇을 하며 놀았을까요?",
                 postThumbnailImage: "testImage2",
                 postImages: ["testImage2", "testImage2", "testImage2", "testImage2"],
                 postImageSources: ["이미지 출처", "이미지 출처", "이미지 출처", "이미지 출처"],
                 postContents: ["testImage3testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage2testImage21", "testImage2", "testImage2", "testImage2"],
                 postEditor: "에디터 이름",
                 postEditorProfileImage: "profileImage",
                 postView: 1132,
                 postCreatedAt: Date(),
                 postUpdatedAt: Date()
                ),
            Post(post_id: "3",
                 postUIType: .normal,
                 postCategory: .culture,
                 postTitle: "그래서 이 아저씨가 누군데??",
                 postThumbnailImage: "testImage7",
                 postImages: ["testImage7", "testImage7", "testImage7", "testImage7"],
                 postImageSources: ["이미지 출처", "이미지 출처", "이미지 출처", "이미지 출처"],
                 postContents: ["testImage7", "testImage7", "testImage7", "testImage7"],
                 postEditor: "에디터 이름",
                 postEditorProfileImage: "profileImage",
                 postView: 1132,
                 postCreatedAt: Date(),
                 postUpdatedAt: Date()
                ),
            Post(post_id: "4",
                 postUIType: .normal,
                 postCategory: .culture,
                 postTitle: "흑백 사진은 언제 처음 사용됐을까?",
                 postThumbnailImage: "testImage3",
                 postImages: ["testImage3", "testImage3", "testImage3", "testImage3"],
                 postImageSources: ["이미지 출처", "이미지 출처", "이미지 출처", "이미지 출처"],
                 postContents: ["testImage3", "testImage3", "testImage3", "testImage3"],
                 postEditor: "에디터 이름",
                 postEditorProfileImage: "profileImage",
                 postView: 1132,
                 postCreatedAt: Date(),
                 postUpdatedAt: Date()
                ),
            Post(post_id: "5",
                 postUIType: .normal,
                 postCategory: .culture,
                 postTitle: "흑백 사진은 언제 처음 사용됐을까?",
                 postThumbnailImage: "testImage5",
                 postImages: ["testImage5", "testImage5", "testImage5", "testImage5"],
                 postImageSources: ["이미지 출처", "이미지 출처", "이미지 출처", "이미지 출처"],
                 postContents: ["testImage5", "testImage5", "testImage5", "testImage5"],
                 postEditor: "에디터 이름",
                 postEditorProfileImage: "profileImage",
                 postView: 1132,
                 postCreatedAt: Date(),
                 postUpdatedAt: Date()
                ),
            Post(post_id: "6",
                 postUIType: .normal,
                 postCategory: .culture,
                 postTitle: "흑백 사진은 언제 처음 사용됐을까?",
                 postThumbnailImage: "testImage4",
                 postImages: ["testImage4", "testImage4", "testImage4", "testImage4"],
                 postImageSources: ["이미지 출처", "이미지 출처", "이미지 출처", "이미지 출처"],
                 postContents: ["testImage4", "testImage4", "testImage4", "testImage4"],
                 postEditor: "에디터 이름",
                 postEditorProfileImage: "profileImage",
                 postView: 1132,
                 postCreatedAt: Date(),
                 postUpdatedAt: Date()
                ),
            Post(post_id: "7",
                 postUIType: .normal,
                 postCategory: .culture,
                 postTitle: "흑백 사진은 언제 처음 사용됐을까?",
                 postThumbnailImage: "testImage6",
                 postImages: ["testImage6", "testImage6", "testImage6", "testImage6"],
                 postImageSources: ["이미지 출처", "이미지 출처", "이미지 출처", "이미지 출처"],
                 postContents: ["testImage6", "testImage6", "testImage6", "testImage6"],
                 postEditor: "에디터 이름",
                 postEditorProfileImage: "profileImage",
                 postView: 1132,
                 postCreatedAt: Date(),
                 postUpdatedAt: Date()
                ),
            Post(post_id: "8",
                 postUIType: .normal,
                 postCategory: .culture,
                 postTitle: "흑백 사진은 언제 처음 사용됐을까?",
                 postThumbnailImage: "testImage8",
                 postImages: ["testImage8", "testImage8", "testImage8", "testImage8"],
                 postImageSources: ["이미지 출처", "이미지 출처", "이미지 출처", "이미지 출처"],
                 postContents: ["testImage8", "testImage8", "testImage8", "testImage8"],
                 postEditor: "에디터 이름",
                 postEditorProfileImage: "profileImage",
                 postView: 1132,
                 postCreatedAt: Date(),
                 postUpdatedAt: Date()
                )
            
        ]
        return Just(postData.filter { $0.post_id == postId }.first!).eraseToAnyPublisher()
    }
    
    public func getSearchGridPostData() -> AnyPublisher<[Post], Never> {
        let posts: [Post] = [
            Post(post_id: "1", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까???", postThumbnailImage: "testImage1"),
            Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
            Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
            Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
            Post(post_id: "5", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
            Post(post_id: "6", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
            Post(post_id: "7", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
            Post(post_id: "8", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8"),
            Post(post_id: "1", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까???", postThumbnailImage: "testImage1"),
            Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
            Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
            Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
            Post(post_id: "5", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
            Post(post_id: "6", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
            Post(post_id: "7", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
            Post(post_id: "8", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8"),
            Post(post_id: "1", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까???", postThumbnailImage: "testImage1"),
            Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
            Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
            Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
            Post(post_id: "5", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
            Post(post_id: "6", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
            Post(post_id: "7", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
            Post(post_id: "8", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8"),
            Post(post_id: "1", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까???", postThumbnailImage: "testImage1"),
            Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
            Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
            Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
            Post(post_id: "5", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
            Post(post_id: "6", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
            Post(post_id: "7", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
            Post(post_id: "8", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8"),
            Post(post_id: "1", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까???", postThumbnailImage: "testImage1"),
            Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
            Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
            Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
            Post(post_id: "5", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
            Post(post_id: "6", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
            Post(post_id: "7", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
            Post(post_id: "8", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8")
        ]
        return Just(posts).eraseToAnyPublisher()
    }
    
    public func getRecentSearchPostData() -> AnyPublisher<[Post], Never> {
        let posts: [Post] = [
            Post(post_id: "1", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까???", postThumbnailImage: "testImage1"),
            Post(post_id: "2", postUIType: .normal, postCategory: .art, postTitle: "그때 그 시절, 무엇을 하며 놀았을까요??", postThumbnailImage: "testImage2"),
            Post(post_id: "3", postUIType: .normal, postCategory: .art, postTitle: "그래서 이 아저씨가 누군데?", postThumbnailImage: "testImage7"),
            Post(post_id: "4", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage3"),
            Post(post_id: "5", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
            Post(post_id: "6", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
            Post(post_id: "7", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
            Post(post_id: "8", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8"),
            Post(post_id: "5", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage5"),
            Post(post_id: "6", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage4"),
            Post(post_id: "7", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage6"),
            Post(post_id: "8", postUIType: .normal, postCategory: .art, postTitle: "흑백 사진은 언제 처음 사용되었을까?", postThumbnailImage: "testImage8")
        ]
        return Just(posts).eraseToAnyPublisher()
    }
}
