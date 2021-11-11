//
//  GroupModel.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

// MARK: - GroupsResponse
struct GroupsResponse: Codable {
    let response: Groups
}

// MARK: - Groups
struct Groups: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Group
struct Group: Codable {
    let id: Int
    let name: String
    let photo: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_200"
    }
}



