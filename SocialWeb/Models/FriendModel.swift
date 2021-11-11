//
//  FriendModel.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import Foundation

// MARK: - FriendsResponse
struct FriendsResponse: Codable {
    let response: Friends
}

// MARK: - Friends
struct Friends: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Friend
struct Friend: Codable {
    let id: Int
    let lastName: String
    let firstName: String
    let photo100: String

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
