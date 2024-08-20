//
//  PostPreviewUseCase.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation

struct PostPreviewUseCase: PostsUseCase {
    func fetch() async throws -> [Post] {
        return try JsonHelper.convert(name: "Posts", type: Posts.self)
    }
}
