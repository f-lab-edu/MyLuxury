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
}
