//
//  PostUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public protocol PostUseCase {
    
    var postRepository: PostRepository { get }
}

public class PostUseCaseImpl: PostUseCase {
    
    public var postRepository: PostRepository
    
    public init(postRepository: PostRepository) {
        print("PostUseCase init")
        self.postRepository = postRepository
    }
    
    deinit {
        print("PostUseCase deinit")
    }
}
