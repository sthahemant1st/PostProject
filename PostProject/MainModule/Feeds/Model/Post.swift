//
//  Post.swift
//  PostUIKIT
//
//  Created by Hemant Shrestha on 18/08/2024.
//

import Foundation

struct Post: Decodable {
    let id: String
    let createdAt: Date
    let postText: String
    let images: [URL]
    let creator: Creator
    
    struct Creator: Decodable {
        let avatar: URL
        let firstName: String
        let lastName: String
    }
}
