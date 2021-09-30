//
//  PhotoModel.swift
//  SocialWeb
//
//  Created by Никитка on 29.09.2021.
//

import Foundation

// MARK: - PhotosResponse
struct PhotosResponse: Codable {
    let response: Photos
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let ownerId: Int
    let sizes: [Size]
    let likes: Like
    let reposts: Repost

    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case sizes
        case likes
        case reposts
    }
}

//MARK: - Size
struct Size: Codable {
    let url: String
}

//MARK: - Like
struct Like: Codable {
    let userLikes: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

//MARK: - Repost
struct Repost: Codable {
    let count: Int
}
