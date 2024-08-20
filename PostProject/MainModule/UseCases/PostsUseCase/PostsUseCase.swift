//
//  PostsUseCase.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation

protocol PostsUseCase {
    func fetch() async throws -> [Post]
}
