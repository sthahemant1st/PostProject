//
//  PostNetworkRepo.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import Foundation

struct PostNetworkRepo: PostRepo {
    private let networkCaller = NetworkCaller()
    
    func getPosts() async throws -> Posts {
        let endPoint = EndPoint(
            path: "/web-n-app-tasks/posts",
            httpMethod: .get
        )
        let responseData = try await networkCaller.request(withEndPoint: endPoint)
        
        return try await handleResponse(
            responseData: responseData,
            returnType: Posts.self
        )
    }
}
