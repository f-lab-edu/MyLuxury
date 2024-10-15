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
        self.postRepository = postRepository
    }
}
