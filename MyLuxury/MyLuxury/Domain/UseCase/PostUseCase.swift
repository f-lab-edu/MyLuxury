//
//  PostUseCase.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Combine

public class PostUseCase {
    
    let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        print("PostUseCase init")
        self.postRepository = postRepository
    }
    
    deinit {
        print("PostUseCase deinit")
    }
}
