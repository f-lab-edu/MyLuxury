//
//  PostRepository.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Foundation
import Combine

public protocol PostRepository {
    func getHomeViewData() -> AnyPublisher<HomePostData, Never>
    func getPostOneData(postId: String) -> AnyPublisher<Post, Never>
    func getSearchGridPostData() -> AnyPublisher<[Post], Never>
    func getRecentSearchPostData() -> AnyPublisher<[Post], Never>
}
