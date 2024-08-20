//
//  PostRepo.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation

protocol PostRepo: BaseRepo {
    func getPosts() async throws -> Posts
}
