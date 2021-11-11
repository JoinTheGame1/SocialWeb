//
//  FriendModel.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import Foundation
import RealmSwift

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
class Friend: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var photo100: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
