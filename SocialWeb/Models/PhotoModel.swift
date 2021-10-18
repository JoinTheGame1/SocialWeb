//
//  PhotoModel.swift
//  SocialWeb
//
//  Created by Никитка on 29.09.2021.
//

import Foundation
import RealmSwift

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
class Photo: Object, Codable {
    @objc dynamic var ownerId: Int = 0
    var sizes = List<Size>()
    @objc dynamic var likes: Like?
    @objc dynamic var reposts: Repost?

    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case sizes
        case likes
        case reposts
    }
}

//MARK: - Size
class Size: Object, Codable {
    @objc dynamic var url: String
}

//MARK: - Like
class Like: Object, Codable {
    @objc dynamic var userLikes: Int
    @objc dynamic var count: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

//MARK: - Repost
class Repost: Object, Codable {
    @objc dynamic var count: Int
}
