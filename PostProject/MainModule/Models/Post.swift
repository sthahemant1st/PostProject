//
//  Post.swift
//  PostUIKIT
//
//  Created by Hemant Shrestha on 18/08/2024.
//

import Foundation

struct Post: Decodable {
    let id: String
    let createdAt: String
    let postText: String
    let images: [String]
    let creator: Creator
    
    struct Creator: Decodable {
        let avatar: String
        let firstName: String
        let lastName: String
        
        var fullName: String {
            "\(firstName) \(lastName)"
        }
    }
}

typealias Posts = [Post]
