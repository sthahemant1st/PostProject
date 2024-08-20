//
//  PostsUseCaseImpl.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation

struct PostsUseCaseImpl: PostsUseCase {
    let repo: PostRepo
    
    func fetch() async throws -> Posts {
        return try await repo.getPosts()
    }
}
