//
//  PhotoModel.swift
//  SocialWeb
//
//  Created by Никитка on 29.09.2021.
//

import UIKit
import RealmSwift

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

    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case sizes
        case likes
    }
}

//MARK: - Size
class Size: Object, Codable {
    @objc dynamic var url: String
    @objc dynamic var width: Int
    @objc dynamic var height: Int
    
    var aspectRatio: CGFloat { return CGFloat(height) / CGFloat(width) }
}

//MARK: - Like
class Like: Object, Codable {
    @objc dynamic var count: Int
    @objc dynamic var user_likes: Int
    
    var liked: Bool { return user_likes == 1}
}

//MARK: - Repost
class Repost: Object, Codable {
    @objc dynamic var count: Int
}
