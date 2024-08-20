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

extension Post {
    static var dummyForSizeCalc: Self {
        .init(
            id: "1",
            createdAt: "",
            postText: "Enim debitis facilis sapiente eius. Adipisci quasi quam dolorem officiis inventore est voluptates. Commodi distinctio possimus. Cupiditate enim quia. Quis vitae numquam aut tempore.",
            images: [],
            creator: .init(
                avatar: "",
                firstName: "John",
                lastName: "Doe"
            )
        )
    }
}
