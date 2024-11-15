//
//  PostViewModel.swift
//  Presentation
//
//  Created by KoSungmin on 11/4/24.
//

import UIKit
import Domain

class PostViewModel {
    let post: Post
    
    init(post: Post) {
        print("PostViewModel init")
        self.post = post
    }
    
    deinit {
        print("PostViewModel deinit")
    }
}
